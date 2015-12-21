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

            def user_update_params
              params.permit(:full_name, :phone)
            end

        end
      end
    end
  end
end
