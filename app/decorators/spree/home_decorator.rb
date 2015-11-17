module Spree
  class HomeDecorator
    include ActiveModel::Serialization

    def banner_types
      Spree::BannerType.includes(:banners).all
    end

  end
end
