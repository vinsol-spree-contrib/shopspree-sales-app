module Spree
  class ProductListDecorator
    include ActiveModel::Serialization

    def initialize(products, product_scope)
      @products       = products
      @product_scope  = product_scope
    end

    attr_reader :products, :product_scope

    def categories
      taxons_with_taxonomy_name('Categories')
    end

    def brands
      taxons_with_taxonomy_name('Brand')
    end

    def option_values
      Spree::OptionValue.joins(variants: :product).merge(product_scope).includes(:option_type).uniq
    end

    def product_properties
      Spree::ProductProperty.joins(:product).merge(product_scope).includes(:property).uniq
    end

    def maximum_price
      Spree::Price.where(currency: Spree::Config[:currency]).joins(variant: :product).merge(Spree::Product.all).maximum(:amount)
    end

    private
      def taxons_with_taxonomy_name(taxonomy_name)
        Spree::Taxon.joins(:taxonomy).merge(Spree::Taxonomy.where(name: taxonomy_name)).joins(classifications: :product)
                  .merge(product_scope).includes(:children).uniq
      end
  end
end
