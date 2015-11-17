require File.expand_path(File.join(File.dirname(__FILE__), '../config', 'environment'))

banner_hash = {}

['promo_offer_banner', 'brand_offer_banner', 'new_arrival_banner', 'category_offer_banner'].each do |banner_name|
  banner_type = Spree::BannerType.where(name: banner_name).first_or_create(presentation: banner_name.humanize)
  Spree::Banner.where('type = ?', "Spree::#{ banner_name.classify }").update_all(type_id: banner_type.id)
end