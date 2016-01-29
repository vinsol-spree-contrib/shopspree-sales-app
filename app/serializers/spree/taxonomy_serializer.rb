module Spree
  class TaxonomySerializer < ActiveModel::Serializer
    attributes :id,
               :name,
               :permalink,
               :pretty_name,
               :checksum


    def permalink
      object.root.permalink
    end

    def pretty_name
      object.root.pretty_name
    end

    has_one :root

    def checksum
      unless options[:include_checksum] == false
        Spree::SalesAppConfiguration.get_latest_config.taxonomies_checksum
      end
    end
  end
end
