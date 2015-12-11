module Spree
  class CreditCardSerializer < ActiveModel::Serializer
    attributes :id,
               :month,
               :year,
               :cc_type,
               :last_digits,
               :created_at,
               :default

  end
end
