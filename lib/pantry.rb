class Pantry
  attr_reader :stock
  def initialize
    @stock = Hash.new(0)
  end

  def stock_check(ingredient)
    @stock[ingredient]
  end

  def restock(ingredient, quantity)
    @stock[ingredient] += quantity
  end

  def enough_ingredients_for?(recipe)
    enough_array = recipe.ingredients_required.map do |ingredient, quantity|
      stock[ingredient] >= quantity
    end
    enough_array.uniq.count == 1 && enough_array[0] == true
  end
end
