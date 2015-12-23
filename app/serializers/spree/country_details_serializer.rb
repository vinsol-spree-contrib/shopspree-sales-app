module Spree
  class CountryDetailsSerializer < ActiveModel::Serializer
    attributes :id, :name, :iso

    has_many :states, serializer: Spree::StateSerializer

  end
end
