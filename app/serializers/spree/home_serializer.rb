module Spree
  class HomeSerializer < ActiveModel::Serializer
    root false

    has_many :banner_types
  end
end
