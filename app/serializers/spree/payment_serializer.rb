module Spree
  class PaymentSerializer < ActiveModel::Serializer
    attributes :id,
               :state

    has_one :source, serializer: SourceSerializer
  end
end
