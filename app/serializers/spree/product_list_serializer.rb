module Spree
  class ProductListSerializer < ActiveModel::Serializer
    root false

    attributes :filters

    has_many :products, serializer: ProductList::ProductSerializer

    def filters
      taxons_filters.concat(option_values_filters).concat(product_properties_filters).concat(prices_filters)
    end

    private

      def taxons_filters
        taxons.map do |taxonomy_name, taxons|
          {
            name:          taxonomy_name,
            values:        taxons.uniq,
            search_key:    object.taxons_search_key,
            filter_type:   ProductListDecorator::FILTER_TYPES[taxonomy_name]
          }
        end
      end


      def product_properties_filters
        product_properties.map do |product_property_presentation, product_properties|
          {
            name:          product_property_presentation,
            values:        product_properties.uniq,
            search_key:    object.product_properties_search_key,
            filter_type:   ProductListDecorator::FILTER_TYPES[product_property_presentation]
          }
        end
      end

      def option_values_filters
        option_values.map do |option_value_presentation, option_values|
          {
            name:          option_value_presentation,
            values:        option_values.uniq,
            search_key:    object.option_values_search_key,
            filter_type:   ProductListDecorator::FILTER_TYPES[option_value_presentation]
          }
        end
      end

      def prices_filters
        [
          {
            name:          'Price',
            values:        object.prices,
            search_key:    object.prices_search_key,
            filter_type:   ProductListDecorator::FILTER_TYPES['Price']
          }
        ]
      end

      def taxons
        objects_hash(object.taxons) do |taxons_hash, taxon|
          taxons_hash[taxon.taxonomy.name] << taxon.name
        end
      end

      def product_properties
        objects_hash(object.product_properties) do |product_properties_hash, product_property|
          product_properties_hash[product_property.property.presentation] << product_property.value
        end
      end

      def option_values
        objects_hash(object.option_values) do |option_values_hash, option_value|
          option_values_hash[option_value.option_type.presentation] << option_value.presentation
        end
      end

      def objects_hash(objects)
        objects.inject(Hash.new { |h, k| h[k] = [] }) do |objects_hash, object|
          yield(objects_hash, object)
          objects_hash
        end
      end
  end
end