module Spree
  module Api
    module Ams
      class HomeController < Spree::Api::BaseController
        include Serializable
        include Requestable

        def show
          @home = Spree::HomeDecorator.new

          render json: @home, serializer: Spree::HomeSerializer
        end
      end
    end
  end
end
