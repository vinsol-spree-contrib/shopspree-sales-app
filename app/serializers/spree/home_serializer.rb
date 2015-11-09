module Spree
  class HomeSerializer < ActiveModel::Serializer
    has_many :hot_products,           serializer: Spree::ProductSerializer
    has_many :recommended_products,   serializer: Spree::ProductSerializer
    has_many :promo_offer_banners,    serializer: Spree::BannerSerializer
    has_many :brand_offer_banners,    serializer: Spree::BannerSerializer
    has_many :category_offer_banners, serializer: Spree::BannerSerializer
    has_many :new_Arrival_banners,    serializer: Spree::BannerSerializer
  end
end
