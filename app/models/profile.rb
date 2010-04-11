class Profile
    
  #
  # As this item is stored in the session, we're not storing the amee_cx
  # We could do so by overriding marshal_load and marshal_dump
  #

  attr_accessor :profile_id, :items
    
  def initialize profile_id
    @profile_id = profile_id
    @items = []
  end
      
  def update amee_cx, *entries
    entries.each do |e|
      cat, data_item_id, amee_params = AMEE::Methodology.send e.amee_method, *e.params
      amee_item = create_item amee_cx, profile_id, cat, data_item_id, amee_params
      e.update amee_item
      items << e
      Rails.logger.info "ProfileItem created by #{e.amee_method} - #{e.co2} kgCo2 - #{e.params.inspect}"
    end
  end
  
  def add_item i
    items << i
  end
      
  def flight_entries
    entries Flight, FlightAggregator
  end
  
  def energy_entries
    entries Energy
  end
  
  def car_entries
    entries Car
  end

  def raw_entries
    entries RawQuantity
  end

  def transport_entries
    entries Bus, Train
  end

  def freight_entries
    entries Freight
  end
  
  def entries *kls
    res = items.select do |i| 
      kls.inject(false) { |sel, k| sel ||= i.is_a? k }
    end
    res.empty? ? [ProfileItem.nil_item] : res
  end 
    
  def total_co2
    items.map { |i| i.co2 }.inject(&:+) || 0
  end
    
  def create_item amee_cx, profile_id, category, data_item_id, params
    params[:name] = rand.to_s[2,20]
    path = "/profiles" / profile_id / category
    AMEE::Profile::Item.create_without_category amee_cx, path, data_item_id, params
  end

  def delete amee_cx, pid
    item = items.find { |i| i.profile_item_id == pid }
    items.delete item
  end 
  
  def clear 
    items.clear
  end 
  
end
