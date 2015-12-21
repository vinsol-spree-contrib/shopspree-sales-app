module Spree
  class LineItemSerializer < ActiveModel::Serializer
    attributes  :id,
                :quantity,
                :price,
                :single_display_amount,
                :display_amount,
                :total,
                :insufficient_stock?,
                :order

    def order
      unless options[:is_embedded_in_order]
        order = object.order
        order.errors[:base] << object.errors.full_messages unless object.valid?
        Spree::OrderSerializer.new(order, options)
      end
    end

    has_one :variant
  end
end
