Spree::Product.class_eval do
  scope :recommended, -> { where(is_recommended: true) }
  scope :hot,         -> { where(is_hot: true) }
end
