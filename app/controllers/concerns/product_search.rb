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
     properties: params[:properties],
     min_price: params[:min_price],
     max_price: params[:max_price]
    }
  end

  class ProductSearchQuery
    # Boost name
    PRODUCT_SEARCH_FIELDS = ["name^5", "description"]
    FILTER_METHODS = [:taxon_filter, :price_filter, :options_filter, :properties_filter]

    def initialize(search_options)
      @search_options = search_options
    end

    def results
      search.load.to_a
    end

    def search
      query = SpreeIndex::Product.query({ multi_match: { query: @search_options[:q], fields: PRODUCT_SEARCH_FIELDS } })
      FILTER_METHODS.each do |filter|
        query = query.filter(send(filter)) if send("#{ filter }_applicable?")
      end
      query
    end

    def aggregates
      # Strategy : Hide one use other filters. and calculate the aggregate.
    end

    private
      def taxon_filter_applicable?
        @search_options[:taxons].present?
      end

      def options_filter_applicable?
        @search_options[:options].present?
      end

      def price_filter_applicable?
        @search_options[:min].present? && @search_options[:max].present?
      end

      def properties_filter_applicable?
        @search_options[:properties].present?
      end

      def taxon_filter
        { terms: { taxons: @search_options[:taxons] } }
      end

      def price_filter
        { range: { price: { gte: @search_options[:min], lte: @search_options[:max] } } }
      end

      def options_filter
        @search_options[:options].collect do |option_name, option_value|
          { terms: { "options.type" => option_name, "options.value" => option_value}}
        end
      end

      def properties_filter
        @search_options[:properties].collect do
          { terms: { "product_properties.name" => prop_name, "product_properties.value" => prop_value}}
        end
      end
  end
end
