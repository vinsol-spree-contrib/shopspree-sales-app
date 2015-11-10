module Spree
  class ProductPropertyType < ActiveRecord::Base
    has_many :product_properties, foreign_key: 'type_id', dependent: :restrict_with_error

    validates :name, presence: true
    validates :name, uniqueness: true, allow_blank: true
  end
end
