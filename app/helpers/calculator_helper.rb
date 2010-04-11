module CalculatorHelper
  
  def formatted_co2 co2
    number_with_precision(co2 / 1000, :precision => 2)
  end
  
  def raw_fmt_cost cost
    "#{number_with_precision cost, :precision => 2}"
  end
  
  def copy_for_tab tab
    {
      "flight" => "Flight",
      "car" => "Car",
      "transport" => "Public<br/>Transport",
      "freight" => "Freight",
      "home" => "Home",
      "energy" => "Energy",
      "quick" => "Quick<br/>Calculator",
      "checkout" => "Checkout",
    }[tab]
  end
  
  def tab_img_src tab, selected
    sel = tab == selected ? "_selected" : ""    
    "/images/tab_#{tab}#{sel}.png"
  end
  
  def tab_class tab, selected
    state, css = :left, nil
    @all_tabs.each do |t|
      state = :right if state == :selected
      state = :selected if t == selected
      css = state if t == tab
    end
    "class='#{css}'"
    css
  end
  
  def header_class type, current
    # type == current || type.blank? && current == "home" ? "class='selected'" :  ""
      
    style = %Q{style="color: #fff; background: transparent url('/images/#{current}_selected.png') no-repeat top left;"}
    type == current || current == "home" ? style : ''
  end
  
  def display_intro
    !session[:intro_viewed]
  end
  
  def business_calculator?
    session[:type] == "business"
  end
  
end
