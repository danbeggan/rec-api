class MealDB::GetRecipes < ApplicationService
  attr_reader :category_name

  def initialize(category_name)
    @category_name = category_name
  end

  def call
    # sends a http request to the meal db api and returns a list of recipes
    response = HTTParty.get("https://www.themealdb.com/api/json/v1/1/filter.php?c=#{@category_name}")
    response['meals']
  end
end
