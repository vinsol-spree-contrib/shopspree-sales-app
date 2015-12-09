module Spree
  module Api
    module Ams
      module User
        class AddressesController < Spree::Api::BaseController
          include Serializable
          include Requestable

          before_action :load_ams_user, only: [:index, :create, :update, :destroy]
          before_action :load_address, only: [:update, :destroy]

          def index
            authorize! :index, @user.shipping_address
            authorize! :index, @user.billing_address
            render json: [@user.shipping_address, @user.billing_address], each_serializer: Spree::AddressSerializer, root: false
          end

          def create
            authorize! :create, Address
            address = Address.new(address_params)
            if address.save
              render json: address, serializer: Spree::AddressSerializer
            else
              invalid_resource!(address)
            end
          end

          def update
            authorize! :update, @address
            if @address.update(address_params)
              render json: @address, serializer: Spree::AddressSerializer
            else
              invalid_resource!(@address)
            end
          end

          def destroy
            authroize! :destroy, @address
            if @address.destroy
              render json: { message: 'Successfully destroyed address ' }
            else
              render json: { error: 'Unable to destroy address ' }, status: 422
            end
          end

          private

            def load_ams_user
              unless @user = Spree.user_class.find_by(spree_api_key: params[:token])
                render json: { errors: 'User not found' }, status: 404
              end
            end

            def load_address
              unless @address = Spree::Address.find_by(id: params[:address_id])
                render json: { errors: 'Address not found' }, status: 404
              end
            end

            def address_params
              params.permit(:address1, :city, :state_id, :country_id, :zip_code, :phone)
            end

        end
      end
    end
  end
end
