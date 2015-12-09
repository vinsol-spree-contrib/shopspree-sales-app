module Spree
  module Api
    module Ams
      class CreditCardsController < Spree::Api::BaseController
        include Serializable
        include Requestable

        before_action :load_ams_user
        before_action :check_presence_of_stripe_token, only: :create
        before_action :load_payment_gateway

        # Params Required
        # => stripe_token (or charge token for stripe)
        # => token : For identifying user
        # Assumptions
        # => Using only one PaymentMethod: Stripe
        # => New stripe customer is created on every request
        def create
          authorize! :create, Spree::CreditCard
          options = {
            email: @user.email,
            login: @payment_gateway.preferences[:secret_key]
          }
          response = @payment_gateway.provider.store(params[:stripe_token], options)
          if response.success?
            @credit_card = Spree::CreditCard.create_from_stripe_response!(response.params, @payment_method, @user)
            render json: @credit_card, serializer: Spree::CreditCardSerializer
          else
            render json: { errors: response.message }, status: 422
          end
        end

        private

          def check_presence_of_stripe_token
            unless params[:stripe_token].present?
              render json: { errors: "stripe token is required" }, status: 422
            end
          end

          def load_payment_gateway
            @payment_gateway = Spree::Gateway::StripeGateway.where(active: true).first
          end

      end
    end
  end
end
