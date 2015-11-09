require File.expand_path(File.join(File.dirname(__FILE__), '../config', 'environment'))

Spree::Banner.where(type: 'Spree::PromoOffer').update_all(type: 'Spree::PromoOfferBanner')
Spree::Banner.where(type: 'Spree::BrandOffer').update_all(type: 'Spree::BrandOfferBanner')