module Spree
  class ProductPropertyType < ActiveRecord::Base
    validates :name, presence: true
    validates :name, uniqueness: true, allow_blank: true
  end
end
