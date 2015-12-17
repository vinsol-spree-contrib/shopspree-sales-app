module Spree
  class ReviewSerializer < ActiveModel::Serializer
    attributes :id, :name, :rating, :title, :review, :user_id
  end
end
