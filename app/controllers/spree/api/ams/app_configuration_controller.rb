module Spree
  module Api
    module Ams
      class AppConfigurationController < Spree::Api::BaseController
        include Serializable
        include Requestable

        def show
          app_configuration = {}
          app_configuration[:country_details] = Spree::Country.find(Spree::Config[:default_country_id])
          render json: app_configuration, serializer: AppConfigurationSerializer
        end
      end
    end
  end
end
