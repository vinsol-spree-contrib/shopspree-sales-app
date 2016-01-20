Spree::Product.class_eval do

  scope :recommended, -> { where(is_recommended: true) }
  scope :hot,         -> { where(is_hot: true) }
  scope :prices_amount_between, -> (min_price, max_price) { joins(:prices).where(spree_prices: { amount: min_price..max_price }) }

  self.whitelisted_ransackable_associations = %w[stores variants_including_master master
                                                 variants taxons product_properties option_values prices]

  def self.ransackable_scopes(auth_object = nil)
    [:prices_amount_between]
  end

  update_index('spree#product') { self }

  def available_options_hash
    available_options_hash = Hash.new { |h, k| h[k] = Set.new }
    self.variants_and_option_values.each do |variant|
      variant.options_hash.each do |option_name, option_value|
        available_options_hash[option_name] << option_value
      end
    end
    available_options_hash.collect { |type, values| { type: type, values: values } }
  end

  def reviews_with_content_count
    reviews.approved
      .where.not(review: nil)
      .where.not(review: '')
      .count
  end

  def spree_api_url
    # currently not using slugs
    Spree::Core::Engine.routes.url_helpers.api_ams_product_path id: id
  end

  # Return a hash of ratings with how many users gave that rating.
  # Example : { 1=>0, 2=>1, 3=>2, 4=>5, 5=>0 }
  def ratings_distribution
    valid_ratings = (1..5).to_a
    distribution = reviews.approved.group(:rating).reorder(:rating).count
    # Add the missing ones with count 0
    valid_ratings.each { |rating| distribution[rating] = 0 unless distribution.has_key?(rating) }
    distribution
  end

end
