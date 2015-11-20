module Spree
  class ProductListDecorator
    include ActiveModel::Serialization

    def initialize(products, product_scope)
      @products       = products
      @product_scope  = product_scope
    end

    attr_reader :products, :product_scope

    def filters
      Spree::Filter.get(self.product_scope)
    end

  end
end
