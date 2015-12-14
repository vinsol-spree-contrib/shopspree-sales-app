module Spree
  class ProductSerializer < ActiveModel::Serializer
    attributes :id, :name, :description, :price, :display_price, :slug, :avg_rating, :reviews_count

    has_many :ratings_with_reviews, serializer: ReviewSerializer, key: 'reviews'
    has_many :product_properties, serializer: ProductPropertiesSerializer
    has_many :images, serializer: ImageSerializer
    has_many :variants_including_master, root: :variants, serializer: VariantSerializer


    def ratings_with_reviews
      object.reviews.approved.ratings_with_reviews.most_recent(object.review_limit || 5)
    end

  end
end
