module Spree
  class TaxonomyFilter < Spree::Filter

    def values
      Spree::Taxon.joins(classifications: :product).merge(product_scope).includes(:children).uniq.pluck(:name)
    end

    def search_key
      if type.eql?('Single')
        :taxons_name_cont
      elsif type.eql?('Multiple')
        :taxons_name_in
      end
    end

  end
end