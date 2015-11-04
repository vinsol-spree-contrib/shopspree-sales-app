module Spree
  class HomeSerializer < ActiveModel::Serializer
    attributes :hot_products,
               :recommended_products
  end
end
