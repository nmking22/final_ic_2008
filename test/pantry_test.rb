require 'minitest/autorun'
require 'minitest/pride'
require './lib/ingredient'
require './lib/pantry'

class PantryTest < Minitest::Test
  def test_it_exists_and_has_readable_attributes
    pantry = Pantry.new

    assert_instance_of Pantry, pantry
    assert_equal ({}), pantry.stock
  end
end
