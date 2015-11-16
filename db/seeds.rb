# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


Spree::Core::Engine.load_seed if defined?(Spree::Core)
Spree::Auth::Engine.load_seed if defined?(Spree::Auth)


['promo_offer_banner', 'brand_offer_banner', 'new_arrival_banner', 'category_offer_banner'].each do |banner_name|
  banner_type = Spree::BannerType.where(name: banner_name).first_or_create(presentation: banner_name.humanize)
end
