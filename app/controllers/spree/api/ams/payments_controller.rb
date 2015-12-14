module Spree
  module Api
    module Ams
      class PaymentsController < Spree::Api::PaymentsController
        include Serializable
        include Requestable

        def new
          @payment_methods = Spree::PaymentMethod.available
          render json: @payment_methods, each_serializer: PaymentMethodSerializer
        end
      end
    end
  end
end
