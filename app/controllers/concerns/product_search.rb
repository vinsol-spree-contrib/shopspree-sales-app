module ProductSearch
  extend ActiveSupport::Concern

  # q: Search Query
  # taxons: list of taxon ids to filter on
  # price_ranges: {min , max}
  # options:      [{type, value}]
  # properties:   [{name, value}]
  def product_search_results
    query = ProductSearchQuery.new(search_options)
    query.results
  end

  def search_options
    {
     q: params[:q],
     taxons: params[:taxons],
     options: params[:options],
     properties: params[:properties]
    }
  end

  class ProductSearchQuery
    PRODUCT_SEARCH_FIELDS = ["name^5", "description"]
    def initialize(search_options)
      @search_options = search_options
    end

    def results
      search.load.to_a
    end

    def search
      SpreeIndex::Product.query({ multi_match: { query: @search_options[:q], fields: PRODUCT_SEARCH_FIELDS } })
    end
  end

end
