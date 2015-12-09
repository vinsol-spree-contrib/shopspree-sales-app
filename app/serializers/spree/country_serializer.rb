module Spree
  class CountrySerializer < ActiveModel::Serializer
    attributes :iso_name, :iso, :iso3, :name, :numcode
  end
end
