class CategoryBlueprint < Blueprinter::Base
  field :id do |object|
    object['idCategory']
  end

  field :name do |object|
    object['strCategory']
  end

  field :description do |object|
    object['strCategoryDescription']
  end

  field :thumbnail do |object|
    object['strCategoryThumb']
  end
end