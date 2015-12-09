module Spree
  class StateSerializer < ActiveModel::Serializer
    attributes :name, :abbr
  end
end
