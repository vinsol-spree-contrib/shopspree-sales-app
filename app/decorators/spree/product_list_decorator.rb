module Spree
  class ProductListDecorator
    include ActiveModel::Serialization

    FILTER_TYPES ||= Hash.new('Multi-Select').merge({ 'Categories' =>  'Single-Select', 'Price' => 'Range', 'Category' => 'Single-Select' })

    def initialize(products, product_scope)
      @products       = products
      @product_scope  = product_scope
    end

    attr_reader :products, :product_scope

    def taxons_search_key
      :taxons_name_in
    end

    def product_properties_search_key
      :product_properties_value_in
    end

    def option_values_search_key
      :variants_option_values_presentation_in
    end

    def prices_search_key
      :prices_amount_between
    end

    def taxons
      Spree::Taxon.joins(classifications: :product).includes(:taxonomy).merge(product_scope).uniq
    end

    def option_values
      Spree::OptionValue.joins(variants: :product).merge(product_scope).includes(:option_type).uniq
    end

    def product_properties
      Spree::ProductProperty.joins(:product).merge(product_scope).joins(:property).merge(Spree::Property.enabled_for_filters).uniq
    end

    def prices
      Spree::Price.where(currency: Spree::Config[:currency]).joins(variant: :product)
                                                       .merge(product_scope).pluck("MIN(spree_prices.amount)", "MAX(spree_prices.amount)")
                                                       .flatten
    end
  end
end
