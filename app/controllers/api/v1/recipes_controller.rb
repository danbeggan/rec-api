class Api::V1::RecipesController < ApplicationController
  def index
    if params[:category_name].blank?
      render json: { error: 'Category name is required' }, status: :bad_request
    else
      recipes = MealDB::GetRecipes.call(params[:category_name])
      render json: RecipeBlueprint.render(recipes)
    end
  end
end
