module Spree
  class ProductList::FilterSerializer < ActiveModel::Serializer
    attributes :id,
               :name,
               :display_name,
               :values,
               :type,
               :search_key
    
    def search_key
      send("#{ object.name.demodulize.underscore }_search_key")
    end

    def taxonomy_filter_search_key
      [:taxons_id_eq, :taxons_name_cont]
    end

    def property_filter_search_key
      [:product_properties_id_eq, :product_properties_value_cont]
    end

    def option_value_filter_search_key
      [:variants_option_values_id_eq, :variants_option_values_name_cont, :variants_option_values_presentation_cont]
    end

    def price_filter_search_key
      [:prices_gt, :prices_lt, :prices_gteq, :prices_lteq, :prices_eq]
    end

  end
end