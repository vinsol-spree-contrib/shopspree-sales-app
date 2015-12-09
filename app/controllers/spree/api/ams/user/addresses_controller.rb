module Spree
  module Api
    module Ams
      module User
        class AddressesController < Spree::Api::BaseController
          include Serializable
          include Requestable

          before_action :load_ams_user, only: [:index, :create, :update, :destroy]

          def index
            authorize! :index, @user
            render json: [@user.shipping_address, @user.billing_address], each_serializer: Spree::AddressSerializer, root: false
          end

          def create
            authorize! :create, @user
            if @user.update_attributes(user_params)
              render_with_serializer
            else
              invalid_resource!(@user)
            end
          end

          def update
          end

          def destroy
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
end
