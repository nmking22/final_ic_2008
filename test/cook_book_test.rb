require 'minitest/autorun'
require 'minitest/pride'
require './lib/ingredient'
require './lib/pantry'
require './lib/recipe'
require './lib/cook_book'
require 'date'
require 'mocha/minitest'
require 'mocha/setup'

class CookBookTest < Minitest::Test
  def test_it_exists_and_has_readable_attributes
    Date.stubs(:today).returns(Date.new(2020,4,22))
    cookbook = CookBook.new

    assert_instance_of CookBook, cookbook
    assert_equal [], cookbook.recipes
    assert_equal "04-22-2020", cookbook.date
  end

  def test_it_can_add_recipes
    cookbook = CookBook.new
    recipe1 = Recipe.new("Mac and Cheese")
    recipe2 = Recipe.new("Cheese Burger")

    cookbook.add_recipe(recipe1)
    cookbook.add_recipe(recipe2)

    assert_equal [recipe1, recipe2], cookbook.recipes
  end

  def test_it_can_return_ingredients
    cookbook = CookBook.new
    ingredient1 = Ingredient.new({name: "Cheese", unit: "C", calories: 100})
    ingredient2 = Ingredient.new({name: "Macaroni", unit: "oz", calories: 30})
    recipe1 = Recipe.new("Mac and Cheese")

    recipe1.add_ingredient(ingredient1, 2)
    recipe1.add_ingredient(ingredient2, 8)

    ingredient3 = Ingredient.new({name: "Ground Beef", unit: "oz", calories: 100})
    ingredient4 = Ingredient.new({name: "Bun", unit: "g", calories: 75})
    recipe2 = Recipe.new("Cheese Burger")

    recipe2.add_ingredient(ingredient1, 2)
    recipe2.add_ingredient(ingredient3, 4)
    recipe2.add_ingredient(ingredient4, 1)

    cookbook.add_recipe(recipe1)
    cookbook.add_recipe(recipe2)

    expected = [ingredient1, ingredient2, ingredient3, ingredient4]

    assert_equal expected, cookbook.ingredients
  end

  def test_it_can_find_highest_calorie_meal
    pantry = Pantry.new
    cookbook = CookBook.new
    ingredient1 = Ingredient.new({name: "Cheese", unit: "C", calories: 100})
    ingredient2 = Ingredient.new({name: "Macaroni", unit: "oz", calories: 30})
    recipe1 = Recipe.new("Mac and Cheese")

    recipe1.add_ingredient(ingredient1, 2)
    recipe1.add_ingredient(ingredient2, 8)

    ingredient3 = Ingredient.new({name: "Ground Beef", unit: "oz", calories: 100})
    ingredient4 = Ingredient.new({name: "Bun", unit: "g", calories: 75})
    recipe2 = Recipe.new("Cheese Burger")

    recipe2.add_ingredient(ingredient1, 2)
    recipe2.add_ingredient(ingredient3, 4)
    recipe2.add_ingredient(ingredient4, 1)

    cookbook.add_recipe(recipe1)
    cookbook.add_recipe(recipe2)

    assert_equal recipe2, cookbook.highest_calorie_meal
  end

  def test_it_can_return_summary
    skip
    cookbook = CookBook.new
    ingredient1 = Ingredient.new({name: "Cheese", unit: "C", calories: 100})
    ingredient2 = Ingredient.new({name: "Macaroni", unit: "oz", calories: 30})
    recipe1 = Recipe.new("Mac and Cheese")

    recipe1.add_ingredient(ingredient1, 2)
    recipe1.add_ingredient(ingredient2, 8)

    ingredient3 = Ingredient.new({name: "Ground Beef", unit: "oz", calories: 100})
    ingredient4 = Ingredient.new({name: "Bun", unit: "g", calories: 1})
    recipe2 = Recipe.new("Burger")

    recipe2.add_ingredient(ingredient3, 4)
    recipe2.add_ingredient(ingredient4, 100)
    cookbook.add_recipe(recipe1)
    cookbook.add_recipe(recipe2)

    expected = [
      {:name=>"Mac and Cheese",
       :details=>{
        :ingredients=>[
          {:ingredient=>"Macaroni",
           :amount=>"8 oz"
           },
          {:ingredient=>"Cheese",
           :amount=>"2 C"}],
       :total_calories=>440}
      },
      {:name=>"Burger",
       :details=>{
        :ingredients=>[
          {:ingredient=>"Ground Beef",
            :amount=>"4 oz"
            },
          {:ingredient=>"Bun",
            :amount=>"100 g"}],
       :total_calories=>500}
       }]

    assert_equal expected, cookbook.summary
  end
end
