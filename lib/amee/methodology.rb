module AMEE

  class Methodology
        
    # http://explorer.amee.com/categories/Generic_plane_transport        
    def self.flight type, origin, destination
      category = "/transport/plane/generic/"
      data_item_id = data_item_id category / type
            
      params = {
        "IATACode1" => origin,
        "IATACode2" => destination,
      }
      
      [category, data_item_id, params]
    end
      
    # http://explorer.amee.com/categories/Generic_plane_transport    
    def self.flight_aggregator distance, count
      category = "/transport/plane/generic/"
      data_item_id = data_item_id category / distance
      
      params = {
        :journeys => count
      }
      
      [category, data_item_id, params]
    end
    
    # http://explorer.amee.com/categories/Uk_energy_by_price
    def self.energy_by_cost energy_type, quantity 
      if energy_type == "electricity" || energy_type == "gas"
        energy_type << "_normal" 
      end
      
      category = "/home/energy/uk/price/"
      data_item_id = data_item_id category / energy_type
      
      params = {
        :currencyGBP => quantity
      }
      
      [category, data_item_id, params]
    end
    
    # http://explorer.amee.com/categories/Energy_by_Quantity/data/electricity
    def self.energy_by_quantity energy_type, quantity   
      category = "/home/energy/quantity"
      data_item_id = data_item_id category / energy_type

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
      data_item_id = data_item_id category / "#{fuel_type}_#{size}"

      params = {
        :distance => distance,
        :distanceUnit => distance_unit
      }
      
      [category, data_item_id, params]
    end
    
    def self.bus distance, distance_unit, journey_count
      category = "/transport/bus/generic"
      data_item_id = data_item_id category / "typical"
      
      params = {
        :distancePerJourney => distance,
        :distancePerJourneyUnit => distance_unit,
        :numberOfJourneys => journey_count,
        :journeyFrequency => "yearly"
      }
      
      [category, data_item_id, params]
    end
    
    def self.train distance, distance_unit, journey_count
      category = "/transport/train/generic"
      data_item_id = data_item_id category / "national"
      
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
      data_item_id = data_item_id category / type
      
      params = {
        :distance => dist,
        :distanceUnit => dist_unit,
        :mass => mass,
        :massUnit => mass_unit,
      }
      
      [category, data_item_id, params]
    end
                
    def self.delete amee_cx, profile_id, item
      path = "/profiles" / profile_id / item.path
      AMEE::Profile::Item.delete amee_cx, path
    end
    
    def self.categories
      %w(
        /transport/plane/generic
        /transport/car/generic
        /home/energy/quantity
        /home/energy/uk/price
        /transport/byDistance/freight
        /transport/bus/generic
        /transport/train/generic
      )
    end
    
    def self.data_item_id key
      meth_name = RAILS_ENV
      AMEE::DataItemCache.send meth_name, key
    end
    
    #
    # Ideally, this method would dynamically define the cache method on
    # initialization in production. For other environments, the script would be
    # run manually and the string returned written to a file. However, given
    # the possibility of timeouts, I feel it's more prudent to statically 
    # create the cache for all environments.
    #
    def self.create_data_item_cache amee_cx
      meth_name = RAILS_ENV

      m_def = "def self.#{meth_name} key\n  {\n"
      
      categories.each do |cat|
        r = amee_cx.get "/data" / cat + "?itemsPerPage=999"
        r = JSON.parse(r.body).to_openstruct
        r.children.dataItems.rows.each do |r|
          tag = r.label.gsub(", ", "_").gsub(" ", "_")
          m_def << %Q{    "#{cat}/#{tag}" => "#{r.uid}",\n}
        end
      end
      
      m_def << "  }[key]\nend"
    end
                
  end
  
end
