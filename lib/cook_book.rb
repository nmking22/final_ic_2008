class CookBook
  attr_reader :recipes
  def initialize
    @recipes = []
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
end
