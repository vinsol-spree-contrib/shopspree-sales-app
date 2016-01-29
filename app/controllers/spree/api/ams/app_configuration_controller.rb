module Spree
  module Api
    module Ams
      class AppConfigurationController < Spree::Api::BaseController
        include Serializable
        include Requestable

        def show
          app_configuration = Spree::SalesAppConfiguration.get_latest_config
          render json: app_configuration, serializer: Spree::SalesAppConfigurationSerializer
        end

        def country_details
          render json: Spree::Country.find(Spree::Config[:default_country_id]), serializer: Spree::CountryDetailsSerializer
        end
      end
    end
  end
end
