class Spree::Api::Ams::SearchesController < Spree::Api::BaseController

  skip_before_action :authenticate_user

  def suggestions
    if params[:q]
      search_results = SpreeIndex.query({ match: { autocomplete: 'tsh' }}).to_a
    else
      search_results = []
    end
    render json: Spree::AutoSuggestSerializer.new(search_results)
  end

  def index
    search_results = []
    render json: search_results, serializer: Spree::ProductSerializer
  end

end
