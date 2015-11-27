module Spree
  module Api
    module Ams
      class User::ConfirmationsController < Spree::Api::BaseController
        include Serializable
        include Requestable

        before_action :load_ams_user, only: :create

        def create
          if @user.send_confirmation_instructions
            render json: { message: 'Mail successfully sent' }
          else
            render json: { errors: 'Unable to send mail' }, status: 422
          end
        end

        private

          def load_ams_user
            unless @user = Spree.user_class.find_by(spree_api_key: params[:token])
              render json: { errors: 'User not found' }, status: 404
            end
          end

      end
    end
  end
end
