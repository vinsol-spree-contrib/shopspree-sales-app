module Spree
  class ProductSerializer < ActiveModel::Serializer
    attributes :id, :name, :description, :price, :display_price, :slug, :avg_rating, :reviews_count, :reviews_with_content_count, :ratings_distribution, :available_options, :available_on

    has_many :product_properties, serializer: ProductPropertiesSerializer
    has_many :images, serializer: ImageSerializer
    has_many :variants_including_master, root: :variants, serializer: VariantSerializer

    def available_options
      object.available_options_hash
    end

    def available_on
      object.available_on.to_formatted_s(:long)
    end
  end
end
