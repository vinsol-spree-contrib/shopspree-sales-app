class Spree::Api::Ams::SearchesController < Spree::Api::BaseController

  MAX_SUGGESTIONS = 5
  skip_before_action :authenticate_user, :load_user

  def suggestions
    suggestions = get_suggestions(params[:q])
    render json: Spree::AutoSuggestSerializer.new(suggestions)
  end

  def index
    search_results = []
    render json: search_results, serializer: Spree::ProductSerializer
  end

  private
  def get_suggestions(to_complete)
    return [] unless to_complete.present?
    SpreeIndex.query({ match: { autocomplete: to_complete }})
      .order(_score: :desc).limit(MAX_SUGGESTIONS).to_a
  end

end
