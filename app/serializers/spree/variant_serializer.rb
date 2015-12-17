module Spree
  class VariantSerializer < ActiveModel::Serializer
    attributes  :id,
                :name,
                :sku,
                :price,
                :weight,
                :height,
                :width,
                :depth,
                :is_master,
                :cost_price,
                :slug,
                :description,
                :track_inventory,
                :display_price,
                :options_text,
                :can_supply?,
                :stock_on_hand

    def stock_on_hand
      object.stock_items.sum(:count_on_hand)
    end

    has_many :images, serializer: ImageSerializer
  end
end
