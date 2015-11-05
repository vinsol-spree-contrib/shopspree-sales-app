module Spree
  module Admin
    class BannersController < ResourceController
      def model_class
        @model_class ||= (params[:type] ? params.delete(:type).safe_constantize : resource.model_class)
      end
    end
  end
end
