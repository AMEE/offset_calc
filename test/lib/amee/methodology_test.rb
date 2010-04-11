require File.join(File.dirname(__FILE__), '..', '..', 'test_helper')

class AMEE::MethodologyTest < ActiveSupport::TestCase
    
  def setup
    # @amee_cx = AMEE::Connection.new "stage.amee.com", "paulcarey", "3d21c90c", :enable_debug => true, :timeout => 25_000
    @amee_cx = AMEE::Connection.new "stage.amee.com", "paulcarey", "3d21c90c", :enable_debug => true
    @profile_id = AMEE::Profile::Profile.create(@amee_cx).uid
    @profile = Profile.new @profile_id
  end

  # test "create generic flights" do
  # end
  # 
  # # Ensure we don't fall foul of one minute limit
  # # This may be at the wrong level - testing this behaviour from 
  # # a profile test might be preferable
  # test "update existing generic flights" do
  # end
  # 
  # test "flights with identicial params can be recreated after deletion" do
  #   item = AMEE::Methodology.flight @amee_cx, @profile_id, nil, "DUB", "COR", "one_way"
  #   AMEE::Methodology.delete @amee_cx, @profile_id, item
  #   AMEE::Methodology.flight @amee_cx, @profile_id, nil, "DUB", "COR", "one_way"
  # end
  
  # def test_home_electricity_by_cost
  #   item = AMEE::Methodology.energy @amee_cx, @profile_id, nil, "electricity", "cost", "50"
  #   assert item.total_amount > 0
  # end
  # 
  # def test_home_electricity_by_consumption
  #   item = AMEE::Methodology.energy @amee_cx, @profile_id, nil, "electricity", "kWh", "50"
  #   assert item.total_amount > 0
  # end
  # 
  # def test_small_car
  #   item = AMEE::Methodology.car @amee_cx, @profile_id, nil, "large", "petrol", 500, "mi"
  #   assert item.total_amount > 0    
  # end
  # 
  # def test_freight
  #   item = AMEE::Methodology.freight @amee_cx, @profile_id, "Road_General", 500, "km", 10, "t"
  #   assert item.total_amount > 0              
  # end

  def test_freight
    freight = Freight.new :transport_type => "Road_General", 
      :distance => 500, :distance_unit => "km", :mass => 10, :mass_unit => "t"
    res = @profile.update @amee_cx, freight
    puts res[0].inspect
    assert res[0].co2 > 0              
  end  
  
  def test_bus
    bus = Bus.new :distance => 50, :distance_unit => "km", :journey_count => 470
    res = @profile.update @amee_cx, bus
    puts res[0].inspect
    assert res[0].co2 > 0
  end
  
end
