module Spree
  module Api
    module Ams
      module User
        class ProfilesController < Spree::Api::BaseController
          include Serializable
          include Requestable

          before_action :load_ams_user, only: :update

          def update
            authorize! :update, @user
            if @user.update_attributes(user_update_params)
              render json: @user, serializer: Spree::UserSerializer
            else
              invalid_resource!(@user)
            end
          end

          private

            def load_ams_user
              unless @user = Spree.user_class.find_by(spree_api_key: params[:token])
                render json: { errors: 'User not found' }, status: 404
              end
            end

            def user_update_params
              params.require(:user).permit(:full_name, :phone)
            end

        end
      end
    end
  end
end
