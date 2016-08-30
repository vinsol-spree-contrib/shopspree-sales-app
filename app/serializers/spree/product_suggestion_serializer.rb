class Spree::ProductSuggestionSerializer < ActiveModel::Serializer
  attributes :suggestion, :type, :product_url

  def type
    "product"
  end

  def suggestion
    object["name"]
  end

  def product_url
    object["product_url"]
  end

end
