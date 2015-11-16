Spree::Price.class_eval do
  scope :with_currency, -> (currency) { where(currency: currency) }
end
