module Spree
  class ShippingMethodSerializer < ActiveModel::Serializer
    attributes  :id,
                :name

    has_many :shipping_categories, serializer: ShippingCategorySerializer

  end
end
