module Spree
  class HomeDecorator
    include ActiveModel::Serialization

    def promo_offer_banners
      Spree::PromoOfferBanner.all
    end

    def brand_offer_banners
      Spree::BrandOfferBanner.all
    end

    def category_offer_banners
      Spree::CategoryOfferBanner.all
    end

    def new_arrival_banners
      Spree::NewArrivalBanner.all
    end
  end
end
