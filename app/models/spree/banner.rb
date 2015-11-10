module Spree
  class Banner < ActiveRecord::Base
    TYPES = ['Spree::PromoOfferBanner', 'Spree::BrandOfferBanner', 'Spree::CategoryOfferBanner', 'Spree::NewArrivalBanner']

    has_attached_file :image, styles: { thumb_960_540: '960x540>', thumb_100_100: '100x100>' }

    validates :type, presence: true
    validates :type, inclusion: { in: TYPES }, allow_blank: true

    validates :target_url, url: true, allow_blank: true
    validates_attachment :image, presence: true,
                                  content_type: { content_type: ['image/jpg', 'image/jpeg', 'image/png', 'image/gif'] },
                                  size: { less_than: 2.megabytes }
  end
end
