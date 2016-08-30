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

  def aggregations
    query = ProductSearchQuery.new(search_options)
    query.aggregates
  end

  def search_options
    {
     q: params[:q],
     taxons: params[:taxons],
     taxon_names: params[:taxon_names],
     options: params[:options],
     properties: params[:properties],
     min_price: params[:min_price],
     max_price: params[:max_price],
     sorting: params[:sorting]
    }
  end

  class ProductSearchQuery
    # Boost name
    PRODUCT_SEARCH_FIELDS = ["name^5", "description"]
    FILTER_METHODS = [:taxon_filter, :price_filter, :options_filter, :properties_filter, :taxon_names_filter]
    AGGREGRATOR_FIELDS = {
      product_properties_agg: { available_properties: :available_values },
      options_agg: { available_options: :available_values },
    }.with_indifferent_access
    SORTING_OPTIONS = {
      name_asc: [{ 'name.untouched' => :asc }, { price: :asc }, { available_on: :desc }],
      name_desc: [{ 'name.untouched' => :desc }, { price: :asc }, { available_on: :desc }],
      price_asc: [{ price: :asc }, { 'name.untouched' => :asc }, { available_on: :desc }],
      price_desc: [{ price: :desc }, { 'name.untouched' => :asc }, { available_on: :desc }],
      available_on_desc: [{ available_on: :desc }, { 'name.untouched' => :asc }, { price: :asc }],
      available_on_asc: [{ available_on: :asc }, { 'name.untouched' => :asc }, { price: :asc }],
      default: [{ 'name.untouched' => :asc }, { price: :asc }, { available_on: :desc }]
    }.with_indifferent_access

    def initialize(search_options)
      @search_options = search_options
    end

    def results
      search_query.order(SORTING_OPTIONS[@search_options[:sorting] || :default]).load.to_a
    end

    def aggregates_not_based_on_any_query
      @aggregates_not_based_on_any_query ||= SpreeIndex::Product.filter{match_all}
        .aggs(:price_ranges)
        .aggs(:taxon_count)
        .aggs(:product_properties_agg)
        .aggs(:options_agg)
        .aggs
    end

    def result_based_aggregation
      @result_based_aggregation ||= search_query.aggs(:price_ranges)
        .aggs(:taxon_count)
        .aggs(:product_properties_agg)
        .aggs(:options_agg)
        .aggs
    end

    def aggregates
      AGGREGRATOR_FIELDS.keys.each do |aggregator|
        aggregator = aggregator.to_s
        if result_based_aggregation[aggregator].present?
          aggregates_not_based_on_any_query[aggregator]['doc_count'] = result_based_aggregation[aggregator]['doc_count']
          update_parent_aggregation(aggregator, aggregates_not_based_on_any_query, result_based_aggregation)
        else
          aggregates_not_based_on_any_query[aggregator]['doc_count'] = 0
          update_parent_aggregation_fields_to_zero(aggregator, aggregates_not_based_on_any_query)
        end
      end
      update_taxon_and_price_aggregators(aggregates_not_based_on_any_query, result_based_aggregation)
      aggregates_not_based_on_any_query
    end

    private
      def update_taxon_and_price_aggregators(aggregates_not_based_on_any_query, result_based_aggregation)
        aggregates_not_based_on_any_query['price_ranges'] = result_based_aggregation['price_ranges']
        taxon_aggregator_not_based_on_query, taxon_result_based_aggregation = aggregates_not_based_on_any_query['taxon_count'], result_based_aggregation['taxon_count']
        update_other_doc_counts(taxon_aggregator_not_based_on_query, taxon_result_based_aggregation)
        update_child_options_doc_counts(taxon_aggregator_not_based_on_query['buckets'], taxon_result_based_aggregation)
      end

      def update_other_doc_counts(main_aggregator_hash, resultant_aggregator_hash)
        main_aggregator_hash['doc_count_error_upper_bound'] = resultant_aggregator_hash.blank? ? 0 : resultant_aggregator_hash['doc_count_error_upper_bound']
        main_aggregator_hash['sum_other_doc_count'] = resultant_aggregator_hash.blank? ? 0 : resultant_aggregator_hash['sum_other_doc_count']
      end

      def update_child_options_doc_counts(main_aggregator_buckets, resultant_aggregator)
        main_aggregator_buckets.each do |value_hash|
          key = value_hash['key']
          if resultant_aggregator.present?
            aggregation_value = resultant_aggregator['buckets'].select { |result_based_value_hash| result_based_value_hash['key'] == key }.first
            value_hash['doc_count'] = aggregation_value.present? ? aggregation_value['doc_count'] : 0
          else
            value_hash['doc_count'] = 0
          end
        end
      end

      def update_parent_aggregation(aggregator, aggregates_not_based_on_any_query, result_based_aggregation)
        AGGREGRATOR_FIELDS[aggregator].keys.each do |aggregator_key|
          aggregator_key = aggregator_key.to_s
          aggregates_not_based_on_query_aggregator, result_based_aggregation_aggregator = aggregates_not_based_on_any_query[aggregator][aggregator_key], result_based_aggregation[aggregator][aggregator_key]
          update_other_doc_counts(aggregates_not_based_on_query_aggregator, result_based_aggregation_aggregator)
          aggregates_not_based_on_query_aggregator['buckets'].each do |option_hash|
            parent_key, option_aggregator_key = option_hash['key'], AGGREGRATOR_FIELDS[aggregator][aggregator_key].to_s
            aggregation_option = result_based_aggregation_aggregator['buckets'].select { |result_based_option_hash| result_based_option_hash['key'] == parent_key }.first
            option_hash['doc_count'] = aggregation_option.present? ? aggregation_option['doc_count'] : 0
            result_based_aggregator = aggregation_option.present? ? aggregation_option[option_aggregator_key] : {}
            option_hash_aggregator = option_hash[option_aggregator_key]
            update_other_doc_counts(option_hash_aggregator, result_based_aggregator)
            update_child_options_doc_counts(option_hash_aggregator['buckets'], result_based_aggregator)
          end
        end
      end

      def update_parent_aggregation_fields_to_zero(aggregator, aggregates_not_based_on_any_query)
        AGGREGRATOR_FIELDS[aggregator].keys.each do |aggregator_key|
          aggregator_key = aggregator_key.to_s
          aggregates_not_based_on_query_aggregator = aggregates_not_based_on_any_query[aggregator][aggregator_key]
          update_other_doc_counts(aggregates_not_based_on_query_aggregator, {})
          aggregates_not_based_on_query_aggregator['buckets'].each do |option_hash|
            parent_key = option_hash['key']
            option_hash['doc_count'] = 0
            option_hash_aggregator = option_hash[AGGREGRATOR_FIELDS[aggregator][aggregator_key].to_s]
            update_other_doc_counts(option_hash_aggregator, {})
            update_child_options_doc_counts(option_hash_aggregator['buckets'], nil)
          end
        end
      end

      def search_query
        if @search_options[:q].present?
          query = SpreeIndex::Product.query({ multi_match: { query: @search_options[:q], fields: PRODUCT_SEARCH_FIELDS } })
        else
          query = SpreeIndex::Product.query({match_all: {}})
        end
        FILTER_METHODS.each do |filter|
          query = query.filter(send(filter)) if send("#{ filter }_applicable?")
        end
        query
      end

      def taxon_filter_applicable?
        @search_options[:taxons].present?
      end

      def taxon_names_filter_applicable?
        @search_options[:taxon_names].present?
      end

      def options_filter_applicable?
        @search_options[:options].present?
      end

      def price_filter_applicable?
        @search_options[:min_price].present? || @search_options[:max_price].present?
      end

      def properties_filter_applicable?
        @search_options[:properties].present?
      end

      def taxon_names_filter
        # Exact Match condition
        # { terms: { taxon_names: @search_options[:taxon_names] } }

        and_filter = []
        unless @search_options[:taxon_names].nil? || @search_options[:taxon_names].empty?
          taxons = @search_options[:taxon_names].split(',').map do |taxon_name|
            and_filter << { term: { taxon_names: taxon_name } }
          end
        end
        and_filter
      end

      def taxon_filter
        # Exact Match condition
        #{ terms: { taxons: @search_options[:taxons] } }

        and_filter = []
        unless @search_options[:taxons].nil? || @search_options[:taxons].empty?
          taxons = @search_options[:taxons].map do |taxon_id|
            and_filter << { term: { taxons: taxon_id } }
          end
        end
        and_filter
      end

      def price_filter
        { range: { price: { gte: @search_options[:min_price], lte: @search_options[:max_price] } } }
      end

      def options_filter
        and_filter = []
        unless @search_options[:options].nil? || @search_options[:options].empty?
          # transform option_types from [{"key1" => ["value_a","value_b"]},{"key2" => ["value_a"]}
          # to { terms: { option_types: ["key1||value_a","key1||value_b"] }
          #    { terms: { option_types: ["key2||value_a"] }
          # This enforces "and" relation between different property values and "or" relation between same property values
          options = @search_options[:options].map{ |key, value| [key].product(value) }.flat_map do |pair|
            and_filter << { terms: { options_values: pair.map { |option| option.join('||') } } }
          end
        end
        and_filter
      end

      def properties_filter
        and_filter = []
        unless @search_options[:properties].nil? || @search_options[:properties].empty?
          # transform properties from [{"key1" => ["value_a","value_b"]},{"key2" => ["value_a"]}
          # to { terms: { properties: ["key1||value_a","key1||value_b"] }
          #    { terms: { properties: ["key2||value_a"] }
          # This enforces "and" relation between different property values and "or" relation between same property values
          properties = @search_options[:properties].map{ |key, value| [key].product(value) }.flat_map do |pair|
            and_filter << { terms: { properties: pair.map { |property| property.join('||') } } }
          end
        end
        and_filter
      end
  end
end
