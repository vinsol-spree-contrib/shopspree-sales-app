module Spree
  module Api
    module Ams
      class StatesController < Spree::Api::BaseController
        include Serializable
        include Requestable

        before_action :load_country, only: :index

        def index
          states = @country.states
          render json: states, each_serializer: Spree::StateSerializer
        end

        private
          def load_country
            unless @country = Spree::Country.find_by(id: params[:country_id])
              render json: { errors: 'Country not found' }, status: 404
            end
          end
      end
    end
  end
end
