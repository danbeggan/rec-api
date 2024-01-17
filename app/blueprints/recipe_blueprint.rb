class RecipeBlueprint < Blueprinter::Base
  field :id do |object|
    object['idMeal']
  end

  field :name do |object|
    object['strMeal']
  end

  field :thumbnail do |object|
    object['strMealThumb']
  end
end