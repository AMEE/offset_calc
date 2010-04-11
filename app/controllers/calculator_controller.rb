class CalculatorController < ApplicationController
  
  # Only required if the calculator is running within an iframe
  before_filter :set_p3p
  
  before_filter :set_amee_cx
  #
  # The before_filter guarantees that a valid profile exists
  # 
  before_filter :verify_session, :except => :index

  #
  # A new profile is created indiscriminately when the user hits the index page
  # The assumption is that no links within the calculator itself will ever
  # invoke this action, but that it will be invoked when the page containing
  # the iframe is called. This ensures that users will always have a empty
  # profile when they enter the calculator.
  #
  def index
    reset_session    
    if ie6?
      # All efforts to stop IE6 blocking cookies from the calculator when run in 
      # a cross domain iframe met in failure. When invoked at the top-level, the
      # calculator works fine in IE6.
      redirect_to "/ie6.html"
    else
      create_session
    end
  end
  
  def home_page
  end

  def start
    if session[:type].blank? || session[:type] == params[:type]
      tab = "?tab=#{params[:tab]}" if !params[:tab].blank?      
      redirect_to "/calculator/#{params[:type]}#{tab}"
    else
      render :template => "calculator/warn"
    end
  end
    
  def personal
    create_session if session[:type] == "business"
    
    session[:type] = "personal"
    @all_tabs = ["quick", "flight", "car", "transport", "home", "checkout"]
    main
  end
  
  def business
    create_session if session[:type] == "personal"
    
    session[:type] = "business"
    @all_tabs = ["quick", "flight", "car", "freight", "energy", "checkout"]
    main
  end
  
  def main
    @tab = params[:tab] || "quick"
    session[:intro_viewed] = true if params[:tab]
    
    @hidden_tabs = @all_tabs.dup
    @hidden_tabs.delete @tab
    
    @total_co2 = profile.total_co2
    @price = APP_CONFIG[:co2_cost].to_f
    @total_cost = ((@total_co2.to_f / 1000) * @price)
    @profile = profile
    
    if @tab == "checkout"
      render :template => "calculator/checkout"
    else
      render :template => "calculator/main"
    end
  end
      
  def energy
    entries = Energy.all.map do |e|
      e.update_attributes params[e.key]
      e
    end
    entries = entries.reject { |e| e.quantity.blank? }

    if entries.map { |e| e.valid? }.inject(&:and)
      profile.update @amee_cx, *entries
    else
      flash[:feedback] = error_copy
    end
    
    tab = type == "business" ? "energy" : "home"
    redirect_to "/calculator/#{type}?tab=#{tab}"    
  end
  
  def car
    car = Car.new params[:car]
    if car.valid?
      profile.update @amee_cx, car
    else
      flash[:feedback] = error_copy
    end
    redirect_to "/calculator/#{type}?tab=car"
  end
  
  def freight
    freight = Freight.new params[:freight]
    if freight.valid?
      profile.update @amee_cx, freight
    else
      flash[:feedback] = error_copy
    end
    redirect_to "/calculator/#{type}?tab=freight"
  end
  
  def quick
    raw = RawQuantity.new params[:raw]
    if raw.valid?
      profile.add_item raw
    else
      flash[:feedback] = error_copy
    end
    redirect_to "/calculator/#{type}?tab=quick"
  end
      
  def flight
    ps = params[:flight]
    flight = ps[:flight_class] == "multiple" ? FlightAggregator.new(ps) : Flight.new(ps) 
    if flight.valid?
      profile.update @amee_cx, flight
    else
      flash[:feedback] = error_copy
    end
    redirect_to "/calculator/#{type}?tab=flight"
  end
  
  def transport
    journey = params[:transport_type] == "bus" ? 
      Bus.new(params[:bus]) : 
      Train.new(params[:train])
    if journey.valid?
      profile.update @amee_cx, journey
    else
      flash[:feedback] = error_copy
    end
    redirect_to "/calculator/#{type}?tab=transport"
  end
      
  def delete_item
    pid = params[:profile_item_id]
    profile.delete @amee_cx, pid
    
    tab = "?tab=#{params[:tab]}" if !params[:tab].blank?
    
    # Use responds_to to not perform redirect based on Content-Type which can
    # be set by an AJAX request. Or alternatively, use a different action.
    
    redirect_to "/calculator/#{type}#{tab}"
  end

  def clear
    profile.clear
    tab = "?tab=#{params[:tab]}" if !params[:tab].blank?
    redirect_to "/calculator/#{type}#{tab}"
  end  
    
  #
  # Target should have been set to _top by submitting form
  # Perhaps reset the session and redirect to target with the
  # selection and cost, depending on integration.
  #
  def donate
    reset_session
    redirect_to "/"
  end
  
  def error_copy
    "Please ensure all values you enter are numbers"
  end
  
  def intro_viewed
    session[:intro_viewed] = true
    respond_to do |f|
      f.html { redirect_to "/calculator/#{type}" }
      f.json { render :json => {:ok => true}.to_json }
    end
  end
  
  protected
  
  def profile
    session[:profile]
  end
  
  def type
    session[:type]
  end
  
  def set_amee_cx
    @amee_cx = global_amee_connection
    @amee_cx.timeout = 10_000
  end
    
  def verify_session
    create_session if session[:profile].nil?
  end
  
  def create_session
    profile_id = AMEE::Profile::Profile.create(@amee_cx).uid
    session[:profile] = Profile.new profile_id
    session[:intro_viewed] = false
    logger.info "Created new profile #{profile_id}"
  end
  
  def set_p3p
    response.headers["P3P"]='CP="NOI DSP COR CURa ADMa DEVa TAIa OUR BUS IND UNI COM NAV INT", policyref="/w3c/p3p.xml"'
  end
  
  def ie6? ua = request.env["HTTP_USER_AGENT"]
    return nil if ua.nil?
    
    ua = ua.downcase
    ie = ua.index('msie')
    if ie
      idx = ua.index('msie ') + 5
      version = ua[idx, ua.length].to_f
      version < 7
    end
  end  
  
end
