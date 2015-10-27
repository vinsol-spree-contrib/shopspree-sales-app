module Spree
  class TaxonSerializer < ActiveModel::Serializer
    attributes :id,
               :name,
               :pretty_name,
               :permalink,
               :parent_id,
               :taxonomy_id,
               :icon_url

    has_many :children

    def icon_url
      object.icon.url(:original)
    end
  end
end