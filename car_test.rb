#### Lesson 4: car test ####

require 'minitest/autorun'
require 'minitest/reporters'
Minitest::Reporters.use!

require_relative 'car'

class CarTest < MiniTest::Test
  def test_wheels
    car = Car.new
    assert_equal(4, car.wheels)
  end

  def test_bad_wheels
    skip "Skipping a test" # Messages can be added to `skip` keyword to provide more detail.
    car = Car.new
    assert_equal(3, car.wheels)
  end
end
