module Spree
  module ProductList
    class ProductSerializer < ActiveModel::Serializer
      attributes :id, :name, :description, :price, :display_price, :slug
    end
  end
end