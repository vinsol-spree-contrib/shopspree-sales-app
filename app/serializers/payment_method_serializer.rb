module Spree
  class PaymentMethodSerializer < ActiveModel::Serializer
    attributes :id,
               :name,
               :description,
               :method_type
  end
end
