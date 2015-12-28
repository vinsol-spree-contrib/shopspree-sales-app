Spree::Product.class_eval do
  scope :recommended, -> { where(is_recommended: true) }
  scope :hot,         -> { where(is_hot: true) }
  scope :prices_amount_between, -> (min_price, max_price) { joins(:prices).where(spree_prices: { amount: min_price..max_price }) }

  self.whitelisted_ransackable_associations = %w[stores variants_including_master master
                                                 variants taxons product_properties option_values prices]

  def self.ransackable_scopes(auth_object = nil)
    [:prices_amount_between]
  end

  def available_options_hash
    available_options_hash = Hash.new { |h, k| h[k] = Set.new }
    self.variants_and_option_values.each do |variant|
      variant.options_hash.each do |option_name, option_value|
        available_options_hash[option_name] << option_value
      end
    end
    available_options_hash
  end

end
