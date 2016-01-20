class Spree::AutoSuggestSerializer < ActiveModel::Serializer

  attributes :suggestions

  SUGGESTION_SERIALIZER = {
   "product" => Spree::ProductSuggestionSerializer,
   "taxon"   => Spree::TaxonSuggestionSerializer
  }

  def suggestions
    object.map(&:_data).collect { |data| SUGGESTION_SERIALIZER[data["_type"]].new(data["_source"]) }
  end

end
