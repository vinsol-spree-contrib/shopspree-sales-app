module Spree
  module ProductList
    class TaxonSerializer < ActiveModel::Serializer
      attributes :id,
                 :name,
                 :pretty_name,
                 :permalink,
                 :icon_url

      def icon_url
        object.icon.url(:original)
      end
    end
  end
end