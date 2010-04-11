class Freight < ProfileItem

  attr_accessor :transport_type, :distance, :distance_unit, :mass, :mass_unit
  
  validates_numericality_of :distance
  validates_numericality_of :mass
    
  def initialize params
    super params
    @amee_method = :freight
  end
  
  def params
    [transport_type, distance, distance_unit, mass, mass_unit]
  end
  
  def self.types_and_keys
    [
      ["Road", "Road_General"],
      ["Rail - Coal", "Train_Coal"],
      ["Rail - Diesel", "Train_Diesel"],
      ["Rail - Electric", "Train_Electric"],      
      ["Flight - Short Haul", "Plane_Short_haul"],
      ["Flight - Medium Haul", "Plane_Medium_haul"],
      ["Flight - Long Haul", "Plane_Long_haul"],
      ["Ship - Inland", "Ship_Inland"],
      ["Ship - Marine", "Ship_Marine"],
    ]
  end
  
  def self.distance_units
    [
      ["Kilometres", "km"],
      ["Miles", "mi"],
      ["Nautical Miles", "nmi"],
    ]
  end
  
  def self.mass_units
    [
      ["Kilograms", "kg"],
      ["Tonnes (Metric)", "t"],
      ["Tons (UK Imperial)", "ton_uk"],
      ["Tons (US Imperial)", "ton_us"],
    ]
  end
  
  def desc 
    if !nil_item?
      tt = Freight.types_and_keys.rassoc(transport_type)[0]
      du = Freight.distance_units.rassoc(distance_unit)[0]
      mu = Freight.mass_units.rassoc(mass_unit)[0]
      "#{tt}: #{distance} #{du} x #{mass} #{mu}"
    end
  end

end
