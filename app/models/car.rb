class Car < ProfileItem

  attr_accessor :size, :fuel_type, :distance, :distance_unit
  
  validates_presence_of     :size
  validates_presence_of     :fuel_type
  validates_numericality_of :distance
  validates_presence_of     :distance_unit
  
  validates_true_for        :fuel_and_size, :logic => :valid_combo
  
  def initialize params
    super params
    @amee_method = :car
    @key = "#{fuel_type}_#{size}"
  end
  
  def valid_combo
    !combos.find { |c| c == key }.nil?
  end
  
  def combos
    f1 = %w(petrol diesel)
    s1 = %w(small medium large)

    f2 = %w(petrol_hybrid cng lpg)
    s2 = %w(medium large)
    
    combine(f1, s1) + combine(f2, s2)
  end
  
  def combine as, bs
    as.map { |s| bs.map { |f| "#{s}_#{f}" } }.flatten
  end
  
  def params
    [size, fuel_type, distance, distance_unit]
  end
  
  def desc
    if !nil_item?
      du = distance_unit == "mi" ? "miles" : "km"
      "#{fuel_type.capitalize} #{size} - #{distance} #{du}"
    end
  end
  
end
