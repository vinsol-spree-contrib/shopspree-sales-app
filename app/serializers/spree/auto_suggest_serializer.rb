class Spree::AutoSuggestSerializer < ActiveModel::Serializer

  attribute :suggestions

  def suggestions
    object.map(&:_data).collect { |data| { type: data["_type"], suggestion: data["_source"]["name"] } }
  end

end
