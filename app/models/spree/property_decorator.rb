module Spree
  Property.class_eval do

    scope :enabled_for_filters, -> { where(enabled_for_filters: true) }

  end
end