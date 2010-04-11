class Energy < ProfileItem
    
  # unit is the chosen unit for this particular energy item. It may be one of
  # cost or the energy_unit for this item
  attr_accessor :unit
  
  attr_accessor :quantity, :energy_unit, :label
  
  validates_numericality_of :quantity
  validates_presence_of     :unit
  
  def initialize params
    super params
  end
  
  def params
    [key, quantity]
  end
  
  def amee_method
    unit == "cost" ? :energy_by_cost : :energy_by_quantity
  end
          
  def self.all
    [
      Energy.new(:key => "electricity", :label => "Electricity", 
        :unit => "kWh", :energy_unit => "kWh"),
      Energy.new(:key => "gas", :label => "Gas", 
        :unit => "kWh", :energy_unit => "kWh"),
      Energy.new(:key => "oil", :label => "Heating Oil", 
        :unit => "litres", :energy_unit => "litres"),
      Energy.new(:key => "coal", :label => "Coal", 
        :unit => "kg", :energy_unit => "kg"),
    ]
  end
  
  def desc
    if !nil_item?
      q = unit == "cost" ? "£#{quantity}" : "#{quantity} #{unit}"
      "#{label} - #{q}"
    end
  end
      
end
