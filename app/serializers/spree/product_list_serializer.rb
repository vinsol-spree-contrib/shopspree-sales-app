module Spree
  class ProductListSerializer < ActiveModel::Serializer
    attributes :filters
    has_many :products
  end
end