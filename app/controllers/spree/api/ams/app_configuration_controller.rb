module Spree
  module Api
    module Ams
      class AppConfigurationController < Spree::Api::BaseController
        include Serializable
        include Requestable

        def show
          app_configuration = {}
          app_configuration[:countries] = Spree::Country.where(iso: 'US')
          render json: app_configuration, serializer: AppConfigurationSerializer
        end
      end
    end
  end
end
