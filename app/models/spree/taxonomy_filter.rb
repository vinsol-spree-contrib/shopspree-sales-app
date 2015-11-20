module Spree
  class TaxonomyFilter < Spree::Filter

    def values
      Spree::Taxon.joins(classifications: :product).merge(product_list.product_scope).includes(:children).uniq.pluck(:name)
    end

  end
end