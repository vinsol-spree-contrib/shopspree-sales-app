Spree::Product.class_eval do
  scope :recommended, -> { where(is_recommended: true) }
  scope :hot,         -> { where(is_hot: true) }

  self.whitelisted_ransackable_associations = %w[stores variants_including_master master 
                                                 variants taxons properties option_values prices]

end
