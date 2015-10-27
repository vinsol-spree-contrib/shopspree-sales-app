module Spree
  class TaxonSerializer < ActiveModel::Serializer
    attributes :id,
               :name,
               :pretty_name,
               :permalink,
               :parent_id,
               :taxonomy_id,
               :icon_path

    has_many :children

    def icon_path
      object.icon.path(:original)
    end
  end
end