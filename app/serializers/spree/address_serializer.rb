module Spree
  class AddressSerializer < ActiveModel::Serializer
    attributes  :id,
                :firstname,
                :lastname,
                :address1,
                :address2,
                :city,
                :zipcode,
                :phone,
                :state_name,
                :alternative_phone,
                :company,
                :state_id,
                :country_id

    # has_one :state, serializer: StateSerializer
    # has_one :country, serializer: CountrySerializer
  end
end
