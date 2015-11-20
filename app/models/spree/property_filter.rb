module Spree
  class PropertyFilter < Spree::Filter

    def values
      product_list.product_properties.pluck(:value)
    end

  end
end