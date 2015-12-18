module Spree
  module Api
    module Ams
      class DevicesController < Spree::Api::BaseController
        include Serializable
        include Requestable

        before_action :load_ams_user, if: -> { params[:token].present? }
        before_action :find_or_initialize_registered_device
        before_action :not_found, only: [:deregister, :unlink], unless: -> { @device.id.present? }

        # POST
        # => /api/ams/devices/register
        def register
          if @device.update(device_params)
            respond_with @device
          else
            respond_with @device, status: 422
          end
        end

        # DELETE
        # => /api/ams/devices/deregister
        def deregister
          authorize! :deregister, @device
          if @device.destroy
            render json: { success: true }, status: 200
          else
            respond_with @device, status: 422
          end
        end

        # PATCH
        # => /api/ams/devices/unlink
        def unlink
          authorize! :unlink, @device
          if @device.unlink
            render json: { success: true }, status: 200
          else
            respond_with @device, status: 422
          end
        end

        private
        def device_params
          params.require(:device)
            .permit(:device_token)
            .merge({ user_id: @user.try(:id) })
        end

        def return_404
          render json: { message: "device not found" }, status: 404
        end

        def find_or_initialize_registered_device
          @device = Spree::Device.find_or_initialize_by(device_token: params[:device_token])
        end

      end
    end
  end
end
