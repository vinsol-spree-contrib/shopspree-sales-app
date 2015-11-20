module Spree
  class Filter < ActiveRecord::Base
    self.inheritance_column = :name

    cattr_accessor :product_scope

    TYPES = ['Range', 'Multiple', 'Single']
    NAMES = ['Spree::TaxonomyFilter', 'Spree::PropertyFilter', 'Spree::OptionValueFilter', 'Spree::PriceFilter']

    validates :display_name, presence: true
    validates :name, inclusion: { in: NAMES }
    validates :type, inclusion: { in: TYPES }

    def self.get(product_scope)
      self.product_scope = product_scope
      self.all
    end

  end
end
