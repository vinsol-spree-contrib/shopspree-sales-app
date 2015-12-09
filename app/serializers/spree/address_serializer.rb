module Spree
  class AddressSerializer < ActiveModel::Serializer
    attributes :id, :first_name, :last_name, :address1, :address2, :city,
               :zipcode, :phone, :state_name, :alternative_phone, :company

    has_one :country
    has_one :state
  end
end
