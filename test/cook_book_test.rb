require 'minitest/autorun'
require 'minitest/pride'
require './lib/ingredient'
require './lib/pantry'
require './lib/recipe'
require './lib/cook_book'

class CookBookTest < Minitest::Test
  def test_it_exists_and_has_readable_attributes
    cookbook = CookBook.new

    assert_instance_of CookBook, cookbook
    assert_equal [], cookbook.recipes
  end
end
