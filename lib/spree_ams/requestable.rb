module Spree
  module Api
    module Ams
      module Requestable
        extend ActiveSupport::Concern

        def load_user
          super
          @current_api_user = Spree.user_class.new if @current_api_user.nil?
        end

      end
    end
  end
end