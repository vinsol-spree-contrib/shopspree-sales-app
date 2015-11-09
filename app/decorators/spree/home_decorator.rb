module Spree
  class HomeDecorator
    include ActiveModel::Serialization

    def hot_products
      Spree::Product.hot.includes(:product_properties, :variants_including_master, master: :images).limit(5)
    end

    def recommended_products
      Spree::Product.recommended.includes(:product_properties, :variants_including_master, master: :images).limit(5)
    end

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
