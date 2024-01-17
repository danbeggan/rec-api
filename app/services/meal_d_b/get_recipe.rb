class MealDB::GetRecipe < ApplicationService
  attr_reader :recipe_id

  def initialize(recipe_id)
    @recipe_id = recipe_id
  end

  def call
    # sends a http request to the meal db api and returns a recipe
    response = HTTParty.get("https://www.themealdb.com/api/json/v1/1/lookup.php?i=#{@recipe_id}")
    response['meals'].present? ? response['meals'].first : nil
  end
end
