module Spree
  class Filter < ActiveRecord::Base
    self.inheritance_column = :name

    cattr_accessor :product_list

    TYPES = ['Range', 'Multiple', 'Single']
    NAMES = ['Spree::TaxonomyFilter', 'Spree::PropertyFilter', 'Spree::OptionValueFilter', 'Spree::PriceFilter']

    validates :display_name, presence: true
    validates :name, inclusion: { in: NAMES }
    validates :type, inclusion: { in: TYPES }

    def self.get(product_list)
      self.product_list = product_list
      self.all
    end

  end
end
