module Spree
  class ProductListSerializer < ActiveModel::Serializer

    has_many :products, serializer: Spree::ProductList::ProductSerializer
    has_many :filters, serializer: Spree::ProductList::FilterSerializer

  end
end