Spree::Taxon.class_eval do
  update_index('spree#taxon') { self }
end
