class RawQuantity < ProfileItem

  attr_accessor :quantity
  
  validates_numericality_of :quantity
  
  def initialize params
    super params
    @key = "raw"

    self.profile_item_id = rand.to_s[2,99]
    self.co2 = quantity.to_f * 1000
  end
    
  def desc
    if !nil_item?
      "#{quantity} tonnes"
    end
  end  
  
end

