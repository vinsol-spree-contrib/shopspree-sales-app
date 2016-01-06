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
    field :price, type: 'double'
    field :sku, index: 'not_analyzed'
    field :taxon_ids, value: -> (product) { product.taxons.map(&:id) }, index: 'not_analyzed'
    field :properties, value: -> (product) { product.product_properties.map{|pp| "#{pp.property.name}||#{pp.value}"} }, index: 'not_analyzed'
  end
  define_type Spree::Taxon do
    field :name, analyzer: 'nGram_analyzer', boost: 100
    field :autocomplete, analyzer: 'autocomplete_analyzer', value: -> (product) { product.name }
    field :description, analyzer: 'snowball'
  end
end
