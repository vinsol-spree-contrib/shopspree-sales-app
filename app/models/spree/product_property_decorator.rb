Spree::ProductProperty.class_eval do
  belong_to :type, class_name: 'Spree::ProductPropertyType'

  validates :type, presence: true
end