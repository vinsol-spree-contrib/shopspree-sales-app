class SpreeIndex < Chewy::Index
  settings analysis: {
             analyzer: {
                 nGram_analyzer: {
                    type: "custom",
                    filter: ["lowercase", "asciifolding", "nGram_filter"],
                    tokenizer: "whitespace" },
                 whitespace_analyzer: {
                    type: "custom",
                    filter: ["lowercase", "asciifolding"],
                    tokenizer: "whitespace" },
                 autocomplete_analyzer: {
                    type: 'custom',
                    filter: ['lowercase', 'edge_gram_filter'],
                    tokenizer: 'whitespace'
                 }
              },
              filter: {
                 nGram_filter: {
                    max_gram: "20",
                    min_gram: "3",
                    type: "nGram",
                    token_chars: ["letter", "digit", "punctuation", "symbol"] },
                 edge_gram_filter: {
                     max_gram: "20",
                     min_gram: "1",
                     type: "edgeNGram",
                     token_chars: ["letter", "digit", "punctuation"]
                 }
              }
          }

  define_type Spree::Product do
    field :name, analyzer: 'nGram_analyzer', boost: 100
    field :autocomplete, analyzer: 'autocomplete_analyzer', value: -> (product) { product.name }
    field :description, analyzer: 'snowball'
    field :available_on, type: 'date', format: 'dateOptionalTime'
    field :product_url,  index: 'not_analyzed', value: -> { spree_api_url }
    field :prices, type: 'double', value: -> { variants_including_master.collect(&:price) }
    field :sku, index: 'not_analyzed'
    field :taxons,  value: -> { taxons.map(&:id) }, index: 'not_analyzed'

    field :product_properties, type: 'nested', value: -> { product_properties } do
      field :name,     index: 'not_analyzed', value: -> { property.name }
      field :value,    index: 'not_analyzed'
    end

    field :options, type: 'nested', include_in_parent: true, value: -> { available_options_hash } do
      field :type,   index: 'not_analyzed'
      field :values, index: 'not_analyzed'
    end

    agg :price_ranges do
      # interval determines the step size
      # Use extended range if needed to increase the interval size
      { histogram: { field: "prices", interval: 100 } }
    end

    agg :taxon_count do
      { terms: { field: 'taxons', size: 10000 } }
    end

    agg :product_properties_agg do
      {
       nested: { path: "product_properties" },
       aggs:
       {
        available_properties:
        {
         terms: {  field: 'product_properties.name' } ,
         aggs:  {  available_values: { terms: { field: 'product_properties.value'} } }
        }
       }
      }
    end

    agg :options_agg do
      {
       nested: { path: "options" },
       aggs:
       {
        available_options:
        {
         terms: {  field: 'options.type' } ,
         aggs:  {  available_values: { terms: { field: 'options.values'} } }
        }
       }
      }
    end
  end
  define_type Spree::Taxon do
    field :name, analyzer: 'nGram_analyzer', boost: 100
    field :autocomplete, analyzer: 'autocomplete_analyzer', value: -> { name }
    field :suggestables, type: 'nested', value: -> { associated_suggestables_with_product_filter_urls } do
      field :name
      field :product_filter_url
    end
    field :description, analyzer: 'snowball'
    field :product_filter_url, value: -> { spree_api_product_filter_url }
  end
end
