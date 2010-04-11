require File.join(File.dirname(__FILE__), '..', 'test_helper')

class CarTest < ActiveSupport::TestCase
    
  def test_valid_combo
    defaults = {:distance => 1, :distance_unit => "kmph"}
    
    params = {:size => "small", :fuel_type => "petrol"}
    c = Car.new defaults.merge(params) 
    assert c.valid?

    params = {:size => "small", :fuel_type => "hybrid"}
    c = Car.new defaults.merge(params) 
    assert !c.valid?
    assert_equal "is invalid", c.errors.on(:fuel_and_size)
  end  
  
end
