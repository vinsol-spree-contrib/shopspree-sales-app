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
            render json: @user.addresses, each_serializer: Spree::AddressSerializer, root: false
          end

          def create
            authorize! :create, Address
            address = @user.addresses.build(address_params)
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
            authorize! :destroy, @address
            if @address.destroy
              render json: { message: 'Successfully destroyed address ' }
            else
              render json: { error: 'Unable to destroy address ' }, status: 422
            end
          end

          private

            def load_address
              unless @address = @user.addresses.find_by(id: params[:address_id])
                render json: { errors: 'Address not found' }, status: 404
              end
            end

            def address_params
              params.require(:address).permit(permitted_address_attributes)
            end

        end
      end
    end
  end
end
