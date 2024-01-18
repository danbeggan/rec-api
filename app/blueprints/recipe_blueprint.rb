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

  view :show do
    field :category do |object|
      object['strCategory']
    end

    field :area do |object|
      object['strArea']
    end

    field :instructions do |object|
      object['strInstructions']
    end

    field :tags do |object|
      object['strTags']
    end

    field :youtube do |object|
      object['strYoutube']
    end

    field :ingredients do |object|
      ingredients = []

      object.each do |key, value|
        if key.include?('strIngredient') && value.present?
          measure = object["strMeasure#{key.split('strIngredient').last}"]
          ingredients << (measure.present? ? "#{measure} #{value}" : value)
        end
      end
      ingredients
    end

    field :source do |object|
      object['strSource']
    end

    field :date_modified do |object|
      object['dateModified']
    end

    field :creative_commons_confirmed do |object|
      object['strCreativeCommonsConfirmed']
    end

    field :image_source do |object|
      object['strImageSource']
    end

    field :date_modified do |object|
      object['dateModified']
    end
  end
end