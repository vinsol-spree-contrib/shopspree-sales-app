module Spree
  class ProductPropertiesSerializer < ActiveModel::Serializer
    attributes :id, :product_id, :value, :property_name, :presentation, :type_name

    def type_name
      object.type.try(:name)
    end

    def presentation
      object.property.presentation
    end
  end
end
