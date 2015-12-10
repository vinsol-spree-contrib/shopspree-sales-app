module Spree
  class StateSerializer < ActiveModel::Serializer
    attributes :id, :name, :abbr
  end
end
