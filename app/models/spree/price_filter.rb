module Spree
  class PriceFilter < Spree::Filter

    def values
      max_and_min_prices
    end

    def max_and_min_prices
      prices = {}
      prices[:max_price], prices[:min_price] = Spree::Price.where(currency: Spree::Config[:currency]).joins(variant: :product).merge(product_scope)
                  .pluck('MAX(`spree_prices`.`amount`), MIN(`spree_prices`.`amount`)').flatten.map(&:to_f)
      prices
    end

    def search_key
      [:prices_amount_between]
    end

  end
end