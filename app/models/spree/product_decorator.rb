Spree::Product.class_eval do

  attr_accessor :review_limit

  scope :recommended, -> { where(is_recommended: true) }
  scope :hot,         -> { where(is_hot: true) }
  scope :prices_amount_between, -> (min_price, max_price) { joins(:prices).where(spree_prices: { amount: min_price..max_price }) }

  self.whitelisted_ransackable_associations = %w[stores variants_including_master master
                                                 variants taxons product_properties option_values prices]

  def self.ransackable_scopes(auth_object = nil)
    [:prices_amount_between]
  end

end
