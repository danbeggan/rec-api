class MealDB::GetCategories < ApplicationService
  def call
    # sends a http request to the meal db api and returns a list of categories
    response = HTTParty.get('https://www.themealdb.com/api/json/v1/1/categories.php')
    response['categories']
  end
end