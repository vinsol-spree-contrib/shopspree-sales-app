module Spree
  class ProductSerializer < ActiveModel::Serializer
    attributes :id, :name, :description, :price, :display_price, :slug, :ratings_count, :average_rating, :reviews_count, :available_options

    has_many :product_properties, serializer: ProductPropertiesSerializer
    has_many :images, serializer: ImageSerializer
    has_many :variants_including_master, root: :variants, serializer: VariantSerializer

    ## Remove this fields when they are actually added to the product.

    def ratings_count
      40
    end

    def average_rating
      3.4
    end

    def reviews_count
      20
    end

    def available_options
      object.available_options_hash
    end

  end
end
