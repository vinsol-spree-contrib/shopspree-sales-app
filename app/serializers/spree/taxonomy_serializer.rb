module Spree
  class TaxonomySerializer < ActiveModel::Serializer
    attributes :id,
               :name,
               :permalink,
               :pretty_name,

    def permalink
      object.root.permalink
    end

    def pretty_name
      object.root.pretty_name
    end

    has_one :root

  end
end
