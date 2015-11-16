module Spree
  class ProductListSerializer < ActiveModel::Serializer
    attributes :maximum_price, :product_properties, :option_values

    has_many :categories, serializer: Spree::ProductList::TaxonSerializer
    has_many :brands, serializer: Spree::ProductList::TaxonSerializer
    has_many :products, serializer: Spree::ProductList::ProductSerializer

    def product_properties
      object.product_properties.inject(Hash.new { |h, k| h[k] = [] }) do |product_properties_hash, product_property|
        product_properties_hash[product_property.property.presentation] << product_property.value
        product_properties_hash
      end
    end

    def option_values
      object.option_values.inject(Hash.new { |h, k| h[k] = [] }) do |option_values_hash, option_value|
        option_values_hash[option_value.option_type.presentation] << option_value.presentation
        option_values_hash
      end
    end
  end
end