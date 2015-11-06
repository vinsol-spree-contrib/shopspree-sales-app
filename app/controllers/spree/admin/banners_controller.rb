module Spree
  module Admin
    class BannersController < ResourceController
      protected
        def model_class
          @model_class ||= fetch_model_class_from_type
        end

        def fetch_model_class_from_type
          banner_type = params.fetch(:banner, {}).delete(:type)
          banner_type.present? ? banner_type.safe_constantize : resource.model_class
        end

        def location_after_save
          admin_banners_path
        end
    end
  end
end
