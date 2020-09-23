class CookBook
  attr_reader :recipes,
              :date
  def initialize
    @recipes = []
    @date = Date.today.strftime("%m-%d-%Y")
  end

  def add_recipe(recipe)
    @recipes << recipe
  end

  def ingredients
    all_ingredients = @recipes.map do |recipe|
      recipe.ingredients.map do |ingredient|
        ingredient
      end
    end.flatten.uniq
  end

  def highest_calorie_meal
    @recipes.max_by do |recipe|
      recipe.total_calories
    end
  end

  def summary
    summary_array = @recipes.map do |recipe|
      recipe_hash = Hash.new
      recipe_hash[:name] = recipe.name
      recipe_hash[:details] = Hash.new
      recipe_hash[:details][:ingredients] = recipe.ingredients_required.map do |ingredient, quantity|
        ingredient_hash = Hash.new
        ingredient_hash[:ingredient] = ingredient.name
        ingredient_hash[:amount] = "#{quantity} #{ingredient.unit}"
        ingredient_hash
      end
      # recipe_hash[:details][:ingredients].sort_by! do |ingredient|
      #   ingredient[:name]
      # end.reverse
      recipe_hash[:total_calories] = recipe.total_calories
      recipe_hash
    end
  end
end
