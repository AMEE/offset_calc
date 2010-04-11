class ProfileItem
  include Validatable
  
  attr_reader :amee_method
  
  attr_accessor :profile_item_id, :key, :co2, :category, :desc, :path
      
  def initialize hash = {}
    update_attributes hash
  end
  
  def update amee_item
    if !amee_item.nil?
      self.profile_item_id = amee_item.uid
      self.co2 = amee_item.total_amount
      self.path = amee_item.path
    end
  end
  
  def update_attributes hash = {}
    hash.each do |k,v|
      send "#{k}=", v
    end
  end
  
  def == o
    o && profile_item_id == o.profile_item_id
  end
  
  def nil_item?
    profile_item_id == "nil_item"
  end
    
  def self.nil_item
    new :co2 => 0, :profile_item_id => "nil_item"
  end
      
end
