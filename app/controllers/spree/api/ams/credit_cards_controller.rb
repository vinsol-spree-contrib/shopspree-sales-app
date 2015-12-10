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
          @credit_card = @user.credit_cards.build(credit_card_params)
          @credit_card.payment_method = payment_gateway
          if @credit_card.save
            render json: @credit_card, serializer: Spree::CreditCardSerializer
          else
            render json: { errors: @credit_card.errors.full_messages.join(', ') }, status: 422
          end
        end

        # DELETE /api/ams/users/credit_cards/:id
        def destroy
          authorize! :destroy, @credit_card

          if @credit_card.destroy
            render json: { message: 'Card destroyed' }, status: 200
          else
            logger.tagged('DELETE Credit Card') { logger.info(@credit_card.errors.full_messages.join(', ') + ". Credit Card Id: #{ @credit_card.id }") }
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

          def credit_card_params
            params.require(:credit_card).permit(permitted_credit_card_attributes)
          end

          def check_presence_of_stripe_token
            unless params[:credit_card][:gateway_payment_profile_id].present?
              render json: { errors: "stripe token is required" }, status: 422
            end
          end

          def payment_gateway
            @payment_gateway ||= Spree::Gateway::StripeGateway.where(active: true).first
          end

          def load_credit_card
            @credit_card = Spree::CreditCard.find_by(id: params[:id])
            unless @credit_card
              render json: { errors: "Can't find credit card with id: #{ params[:id] }" }, status: 422
            end
          end
      end
    end
  end
end
