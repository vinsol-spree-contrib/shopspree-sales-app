module Spree
  class LineItemSerializer < ActiveModel::Serializer
    attributes  :id,
                :quantity,
                :price,
                :single_display_amount,
                :display_amount,
                :total,
                :insufficient_stock?

    has_one :variant
  end
end
