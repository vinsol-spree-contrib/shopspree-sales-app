Spree::Taxonomy.class_eval do
  scope :with_name, -> (name) { where(name: name) }
end
