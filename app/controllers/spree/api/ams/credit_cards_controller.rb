module Spree
  module Api
    module Ams
      class CreditCardsController < Spree::Api::BaseController
        include Serializable
        include Requestable

        before_action :load_ams_user
        before_action :check_presence_of_stripe_token, only: :create
        before_action :load_credit_card, only: :destroy

        # POST: /api/ams/users/credit_cards
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
            login: payment_gateway.preferences[:secret_key]
          }
          response = payment_gateway.provider.store(params[:stripe_token], options)
          if response.success?
            @credit_card = Spree::CreditCard.create_from_stripe_response!(response.params, @payment_method, @user)
            render json: @credit_card, serializer: Spree::CreditCardSerializer
          else
            render json: { errors: response.message }, status: 422
          end
        end

        # DELETE /api/ams/users/credit_cards/:id
        def destroy
          authorize! :destroy, @credit_card

          # Deleting the whole customer as we are storing one card per customer on stripe.
          # To delete only a card, pass a second arg as a hash => { card_id: card_id: @credit_card.gateway_payment_profile_id }
          response = payment_gateway.provider.unstore(@credit_card.gateway_customer_profile_id)
          if response.success? && @credit_card.destroy
            render json: { message: 'Card destroyed' }, status: 200
          else
            logger.tagged('DELETE Credit Card') { logger.info(response.message + ". Credit Card Id: #{ @credit_card.id }") }
            render json: { errors: "Unable to destroy the card" }, status: 422
          end
        end

        # GET /api/ams/users/credit_cards
        def index
          authorize! :read, Spree::CreditCard
          @credit_cards = @user.credit_cards
          render json: @credit_cards, each_serializer: Spree::CreditCardSerializer, root: false
        end

        private

          def check_presence_of_stripe_token
            unless params[:stripe_token].present?
              render json: { errors: "stripe token is required" }, status: 422
            end
          end

          def payment_gateway
            @payment_gateway ||= Spree::Gateway::StripeGateway.where(active: true).first
          end

          def load_credit_card
            @credit_card = Spree::CreditCard.find_by(id: params[:id])
            unless @credit_card
              render json: { errors: "Can't find credit card with id: #{params[:id]}" }, status: 422
            end
          end
      end
    end
  end
end
