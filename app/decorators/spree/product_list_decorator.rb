module Spree
  class ProductListDecorator
    include ActiveModel::Serialization

    def initialize(products, product_scope)
      @products       = products
      @product_scope  = product_scope
      @prices = max_and_min_prices
    end

    attr_reader :products, :product_scope, :prices

    def filters
      Spree::Filter.get(self)
    end

    def option_values
      Spree::OptionValue.joins(variants: :product).merge(product_scope).includes(:option_type).uniq
    end

    def product_properties
      Spree::ProductProperty.joins(:product).merge(product_scope).includes(:property).uniq
    end

    def maximum_price
      prices[0]
    end

    def minimum_price
      prices[1]
    end

    private

      def max_and_min_prices
        Spree::Price.where(currency: Spree::Config[:currency]).joins(variant: :product).merge(product_scope)
                    .pluck('MAX(`spree_prices`.`amount`), MIN(`spree_prices`.`amount`)').flatten
      end

  end
end
