module Spree
  class HomeSerializer < ActiveModel::Serializer
    has_many :promo_offer_banners,    serializer: Spree::BannerSerializer
    has_many :brand_offer_banners,    serializer: Spree::BannerSerializer
    has_many :category_offer_banners, serializer: Spree::BannerSerializer
    has_many :new_arrival_banners,    serializer: Spree::BannerSerializer
  end
end
