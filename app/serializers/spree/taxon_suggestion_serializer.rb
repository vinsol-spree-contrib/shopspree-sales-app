class Spree::TaxonSuggestionSerializer < ActiveModel::Serializer
  attributes :suggestion, :type, :suggestable, :product_filter_url

  def type
    "taxon"
  end

  def suggestion
    object["name"]
  end

  def product_filter_url
    object["product_filter_url"]
  end

  def suggestable
    object["suggestables"]
  end
end
