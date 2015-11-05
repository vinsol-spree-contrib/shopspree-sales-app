module Spree
  class HomeSerializer < ActiveModel::Serializer
    attributes :hot_products,
               :recommended_products

    has_many :promo_offers, serializer: Spree::BannerSerializer
    has_many :brand_offers, serializer: Spree::BannerSerializer
  end
end
