module Spree
  class BannerTypeSerializer < ActiveModel::Serializer
    attributes :id,
               :name,
               :presentation,
               :banners

    has_many :banners

  end
end
