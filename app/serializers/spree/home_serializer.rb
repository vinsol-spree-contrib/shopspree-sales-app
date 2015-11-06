module Spree
  class HomeSerializer < ActiveModel::Serializer
    has_many :hot_products, serializer: Spree::ProductSerializer
    has_many :recommended_products, serializer: Spree::ProductSerializer
    has_many :promo_offers, serializer: Spree::BannerSerializer
    has_many :brand_offers, serializer: Spree::BannerSerializer
  end
end
