module Spree
  class WishlistSerializer < ActiveModel::Serializer

    attributes  :id,
                :name,
                :access_hash,
                :is_private,
                :is_default,
                :created_at,
                :updated_at

    has_many :wished_products, serializer: Spree::WishedProductSerializer
    has_one :user, serializer: Spree::UserSerializer
  end
end
