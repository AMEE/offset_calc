require File.join(File.dirname(__FILE__), '..', '..', 'test_helper')

class AMEE::MethodologyTest < ActiveSupport::TestCase
    
  def setup
    @amee_cx = AMEE::Rails.connection
    @profile_id = AMEE::Profile::Profile.create(@amee_cx).uid
    @profile = Profile.new @profile_id
  end

  def test_flights_airport_codes
    [
      "auto_one_way",
      "auto_return",
    ].each do |flight_type|
      flight = Flight.new :origin => 'LHR', :destination => 'LAX', :type => flight_type
      res = @profile.update @amee_cx, flight
      puts res[0].inspect
      assert res[0].co2 > 0
    end
  end
      
  def test_flights_multiple
    [
      "domestic_return",
      "long_haul_return",
      "short_haul_return",
    ].each do |flight_type|
      flight = FlightAggregator.new :distance => flight_type, :count => 10
      res = @profile.update @amee_cx, flight
      puts res[0].inspect
      assert res[0].co2 > 0
    end    
  end

  def test_energy
    Energy.all.each do |energy|
      energy.quantity = 42
      res = @profile.update @amee_cx, energy
      puts res[0].inspect
      assert res[0].co2 > 0
    end
  end

  def test_energy_by_price
    Energy.all.each do |energy|
      energy.quantity = 42
      energy.unit = 'cost'
      res = @profile.update @amee_cx, energy
      puts res[0].inspect
      assert res[0].co2 > 0
    end
  end

  def test_car
    ['petrol', 'diesel', 'petrol_hybrid', 'cng', 'lpg'].each do |fuel|
      ['large', 'medium', 'small'].each do |size|
        car = Car.new :fuel_type => fuel, :size => size, :distance => 500, :distance_unit => "km"
        if car.valid_combo
          res = @profile.update @amee_cx, car
          puts res[0].inspect
          assert res[0].co2 > 0
        end
      end
    end
  end

  def test_freight
    [
      "Plane_Long_haul",
      "Plane_Medium_haul",
      "Plane_Short_haul",
      "Road_General",
      "Ship_Inland",
      "Ship_Marine",
      "Train_Coal",
      "Train_Diesel",
      "Train_Electric",
    ].each do |type|
      freight = Freight.new :transport_type => type,
        :distance => 500, :distance_unit => "km", :mass => 10, :mass_unit => "t"
      res = @profile.update @amee_cx, freight
      puts res[0].inspect
      assert res[0].co2 > 0
    end
  end

  def test_train
    train = Train.new :distance => 50, :distance_unit => "km", :journey_count => 470
    res = @profile.update @amee_cx, train
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
