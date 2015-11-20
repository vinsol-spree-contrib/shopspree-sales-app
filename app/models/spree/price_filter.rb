module Spree
  class PriceFilter < Spree::Filter

    def values
      { max_price: product_list.maximum_price, min_price: product_list.minimum_price }
    end

  end
end