module Spree
  class HomeSerializer < ActiveModel::Serializer
    has_many :banner_types
  end
end
