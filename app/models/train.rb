class Train < ProfileItem
  
  attr_accessor :distance, :distance_unit, :journey_count

  validates_numericality_of :distance
  validates_presence_of     :distance_unit
  validates_numericality_of :journey_count

  def initialize params
    super params
    @amee_method = :train
  end
  
  def params
    [distance, distance_unit, journey_count]
  end
  
  def desc
    if !nil_item?
      du = distance_unit == "mi" ? "miles" : "km"
      "Train: #{journey_count} x #{distance} #{du}"
    end
  end
  
end
