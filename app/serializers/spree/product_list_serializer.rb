module Spree
  class ProductListSerializer < ActiveModel::Serializer
    has_many :categories
    has_many :brands
    has_many :option_types
  end
end