module Spree
  module Api
    module Ams
      module User
        class ConfirmationsController < Spree::Api::BaseController
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

        end
      end
    end
  end
end
