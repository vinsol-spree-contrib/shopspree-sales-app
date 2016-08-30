module Spree
  module Api
    module Ams
      class SearchesController < Spree::Api::BaseController
        include ProductSearch

        MAX_SUGGESTIONS = 5

        skip_before_action :authenticate_user, :load_user

        def suggestions
          suggestions = get_suggestions(params[:q])
          render json: Spree::AutoSuggestSerializer.new(suggestions)
        end

        def index
          @products = Kaminari.paginate_array(product_search_results).page(params[:page]).per(params[:per_page])
          render json: { searches: ActiveModel::ArraySerializer.new(@products, each_serializer: Spree::ProductSerializer), filters: aggregations }
        end

        private
        def get_suggestions(to_complete)
          return [] unless to_complete.present?
          SpreeIndex.query({ match: { autocomplete: to_complete }})
            .order(_score: :desc).limit(MAX_SUGGESTIONS).to_a
        end
      end
    end
  end
end
