class FlightAggregator < ProfileItem
  
  # Passed via request params - unused at this level
  attr_accessor :flight_class
  attr_accessor :type, :origin, :destination  

  # Specific to this class
  attr_accessor :distance, :count
  
  validates_numericality_of :count
  
  def initialize params
    super params
    @amee_method = :flight_aggregator
  end
  
  def params
    [distance, count]
  end
  
  def desc
    if !nil_item?
      tks = distance.split "_"
      dist = tks[0, tks.length - 1].join " "      
      "#{count} x #{dist}"
    end
  end
  
end
