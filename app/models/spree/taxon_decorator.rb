Spree::Taxon.class_eval do
  update_index('spree#taxon') { self }

  def associated_suggestables_with_product_filter_urls
    associated_suggestables.collect { |assoc_taxon| { name: assoc_taxon.name, product_filter_url: spree_api_product_filter_url(assoc_taxon) } }
  end

  def associated_suggestables
    # use sets to mantain unique taxons
    (associated_suggestables_via_ancestry + associated_suggestables_via_product)
  end

  def spree_api_product_filter_url(*additional_taxons)
    params = { taxon_names: ([self.name] + additional_taxons.collect(&:name)).join(',') }
    Spree::Core::Engine.routes.url_helpers.api_ams_products_path params: params
  end

  private
    def associated_suggestables_via_product
      # All Taxons which share the product and are suggestable, but not the current taxon itself.
      Spree::Taxon.joins(:products)
        .where(suggestable: true)
        .where.not(id: id)
        .where(spree_products: { id: products.pluck(:id) }).to_set
    end

    def associated_suggestables_via_ancestry
      ancestors.where(suggestable: true).to_set
    end
end
