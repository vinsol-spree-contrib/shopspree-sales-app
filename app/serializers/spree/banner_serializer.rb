module Spree
  class BannerSerializer < ActiveModel::Serializer
    attributes :id,
               :image_url,
               :target_url

    def image_url
      object.image.url(:thumb_960_540)
    end

  end
end
