module Spree
  class ProductList::FilterSerializer < ActiveModel::Serializer
    attributes :id,
               :name,
               :display_name,
               :values,
               :type,
               :search_key

  end
end