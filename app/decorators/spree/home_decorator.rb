module Spree
  class HomeDecorator
    include ActiveModel::Serialization

    def banners
      Spree::Banner.all
    end

  end
end
