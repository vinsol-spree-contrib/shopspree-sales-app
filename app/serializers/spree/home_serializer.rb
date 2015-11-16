module Spree
  class HomeSerializer < ActiveModel::Serializer
    has_many :banners,    serializer: Spree::BannerSerializer
  end
end
