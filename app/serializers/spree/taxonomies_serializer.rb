module Spree
  class TaxonomiesSerializer < ActiveModel::Serializer
    attributes :taxonomies, :meta, :checksum

    def taxonomies
      ActiveModel::ArraySerializer.new(object, each_serializer: Spree::TaxonomySerializer)
    end

    def meta
      { total_pages: object.total_pages }
    end

    def checksum
      Spree::SalesAppConfiguration.get_latest_config.taxonomies_checksum
    end
  end
end
