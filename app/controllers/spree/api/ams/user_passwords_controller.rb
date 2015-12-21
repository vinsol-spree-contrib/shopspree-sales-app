module Spree
  module Api
    module Ams
      class UserPasswordsController < Spree::Api::BaseController
        include Serializable
        include Requestable

        before_action :load_user_by_email, only: :create
        before_action :load_ams_user, only: :update
        skip_before_action :authenticate_user, only: :create

        # PATCH api/ams/password/change
        def update
          if @user.update_with_password(password_params)
            render json: @current_api_user, serializer: Spree::UserSerializer
          else
            invalid_resource!(@user)
          end
        end

        # POST api/ams/password/reset
        def create
          if @user.send_reset_password_instructions
            render json: { message: 'Successfully send reset password instructions ' }
          else
            render json: { errors: 'Unable to send reset password instructions '}, status: 422
          end
        end

        private

          def load_user_by_email
            unless @user = Spree.user_class.find_by(email: params[:email])
              render json: { message: 'No user found' }, status: 404
            end
          end

          def password_params
            params.permit(:current_password, :password)
          end

      end
    end
  end
end
