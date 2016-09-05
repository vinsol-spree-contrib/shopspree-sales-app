module Spree
  class WishedProductSerializer < ActiveModel::Serializer

    attributes  :id,
                :remark,
                :quantity,
                :total,
                :wishlist_id

    has_one :variant, serializer: Spree::VariantSerializer
  end
end
