class Api::V1::CategoriesController < ApplicationController
  def index
    categories = MealDB::GetCategories.call
    render json: CategoryBlueprint.render(categories)
  end
end
