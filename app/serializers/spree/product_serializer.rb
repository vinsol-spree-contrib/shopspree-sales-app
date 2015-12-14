module Spree
  class ProductSerializer < ActiveModel::Serializer
    attributes :id, :name, :description, :price, :display_price, :slug, :avg_rating, :reviews_count

    has_many :reviewed_ratings, serializer: ReviewSerializer, key: 'reviews'
    has_many :product_properties, serializer: ProductPropertiesSerializer
    has_many :images, serializer: ImageSerializer
    has_many :variants_including_master, root: :variants, serializer: VariantSerializer


    def reviewed_ratings
      object.reviews.approved.reviewed_ratings.most_recent(object.review_limit || 5)
    end

  end
end
