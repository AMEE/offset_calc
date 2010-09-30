module AMEE

  class Methodology
        
    # http://explorer.amee.com/categories/Generic_plane_transport        
    def self.flight type, origin, destination
      category = "/transport/plane/generic"
      drills={
        "auto_one_way" => "type=auto&size=one+way",
        "auto_return" => "type=auto&size=return",
      }
      data_item_id = uid(category, drills[type])
      params = {
        "IATACode1" => origin,
        "IATACode2" => destination,
      }
      [category, data_item_id, params]
    end
      
    # http://explorer.amee.com/categories/Generic_plane_transport    
    def self.flight_aggregator distance, count
      category = "/transport/plane/generic"
      drills={
        "domestic_return" => "type=domestic&size=return",
        "long_haul_return" => "type=long+haul&size=return",
        "short_haul_return" => "type=short+haul&size=return",
      }
      data_item_id = uid(category, drills[distance])
      params = {
        :journeys => count
      }
      [category, data_item_id, params]
    end
    
    # http://explorer.amee.com/categories/Uk_energy_by_price
    def self.energy_by_cost energy_type, quantity 
      category = "/home/energy/uk/price"
      drills = {
        "coal" => "type=coal&payment=-",
        "electricity" => "type=electricity&payment=normal",
        "gas" => "type=gas&payment=normal",
        "oil" => "type=oil&payment=-",
      }
      data_item_id = uid(category, drills[energy_type])
      params = {
        :currencyGBP => quantity
      }
      [category, data_item_id, params]
    end
    
    # http://explorer.amee.com/categories/Energy_by_Quantity
    def self.energy_by_quantity energy_type, quantity   
      category = "/home/energy/quantity"
      data_item_id = uid(category, "type=#{energy_type}")
      param_key = {
        "electricity" => :energyConsumption,
        "gas" => :energyConsumption,
        "oil" => :volumePerTime,
        "coal" => :massPerTime,
      }[energy_type]
      params = {
        param_key => quantity
      }
      [category, data_item_id, params]
    end
    
    # http://explorer.amee.com/categories/Generic_car_transport
    def self.car size, fuel_type, distance, distance_unit 
      category = "/transport/car/generic"
      data_item_id = uid(category, "fuel=#{fuel_type.gsub('_','+')}&size=#{size}")
      params = {
        :distance => distance,
        :distanceUnit => distance_unit
      }
      [category, data_item_id, params]
    end
    
    # http://explorer.amee.com/categories/Generic_bus_transport
    def self.bus distance, distance_unit, journey_count
      category = "/transport/bus/generic"
      data_item_id = uid(category, "type=typical")
      params = {
        :distancePerJourney => distance,
        :distancePerJourneyUnit => distance_unit,
        :numberOfJourneys => journey_count,
        :journeyFrequency => "yearly"
      }
      
      [category, data_item_id, params]
    end
    
    # http://explorer.amee.com/categories/Generic_train_transport
    def self.train distance, distance_unit, journey_count
      category = "/transport/train/generic"
      data_item_id = uid(category, "type=national")
      params = {
        :distancePerJourney => distance,
        :distancePerJourneyUnit => distance_unit,
        :numberOfJourneys => journey_count,
        :journeyFrequency => "yearly"
      }
      [category, data_item_id, params]
    end
    
    # http://explorer.amee.com/categories/Freight
    def self.freight type, dist, dist_unit, mass, mass_unit
      category = "/transport/byDistance/freight"
      drills={
        "Plane_Long_haul" => "type=plane&subtype=long+haul",
        "Plane_Medium_haul" => "type=plane&subtype=medium+haul",
        "Plane_Short_haul" => "type=plane&subtype=short+haul",
        "Road_General" => "type=road&subtype=general",
        "Ship_Inland" => "type=ship&subtype=inland",
        "Ship_Marine" => "type=ship&subtype=marine",
        "Train_Coal" => "type=train&subtype=coal",
        "Train_Diesel" => "type=train&subtype=diesel",
        "Train_Electric" => "type=train&subtype=electric",
      }
      data_item_id = uid(category, drills[type])
      params = {
        :distance => dist,
        :distanceUnit => dist_unit,
        :mass => mass,
        :massUnit => mass_unit,
      }
      [category, data_item_id, params]
    end

    def self.uid(category, drills)
      AMEE::DataItemCache.get(AMEE::Rails.connection, "#{category}/drill?#{drills}")
    end

    def self.delete amee_cx, profile_id, item
      path = "/profiles" / profile_id / item.path
      AMEE::Profile::Item.delete amee_cx, path
    end
          
  end
  
end
