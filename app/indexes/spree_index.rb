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
    field :price, type: 'double'
    field :sku, index: 'not_analyzed'
    field :taxon_ids,  value: -> { taxons.map(&:id) }, index: 'not_analyzed'
    field :product_properties, type: 'nested', value: -> { product_properties } do
      field :name,  index: 'not_analyzed', value: -> { property.name }
      field :value, index: 'not_analyzed'
    end
    agg  :price_stats do
      { stats: { field: "price" } }
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
