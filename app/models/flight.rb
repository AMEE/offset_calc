class Flight < ProfileItem
  
  # Passed via request params - unused at this level  
  attr_accessor :flight_class
  attr_accessor :distance, :count

  # Specific to this class  
  attr_accessor :type, :origin, :destination
    
  def initialize params
    super params
    @amee_method = :flight
  end
  
  def params
    [type, origin, destination]
  end
  
  def desc
    if !nil_item?
      hr_type = type == "auto_one_way" ? "One way" : "Return"      
      "#{hr_type} from #{origin} to #{destination}"
    end
  end
  
end
