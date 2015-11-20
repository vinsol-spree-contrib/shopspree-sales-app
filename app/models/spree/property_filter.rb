module Spree
  class PropertyFilter < Spree::Filter

    def values
      product_properties.pluck(:value)
    end

    def product_properties
      Spree::ProductProperty.joins(:product).merge(product_scope).includes(:property).uniq
    end

    def search_key
      if type.eql?('Single')
        :product_properties_value_cont
      elsif type.eql?('Multiple')
        :product_properties_value_in
      end
    end

  end
end