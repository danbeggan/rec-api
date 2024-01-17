class Api::V1::RecipesController < ApplicationController
  def index
    if params[:category_name].blank?
      render json: { error: 'Category name is required' }, status: :bad_request
    else
      recipes = MealDB::GetRecipes.call(params[:category_name])
      if recipes
        render json: RecipeBlueprint.render(recipes)
      else
        render json: { error: 'Category not found' }, status: :not_found
      end
    end
  end

  def show
    recipe = MealDB::GetRecipe.call(params[:id])
    if recipe
      render json: RecipeBlueprint.render(recipe, view: :show)
    else
      render json: { error: 'Recipe not found' }, status: :not_found
    end
  end
end
