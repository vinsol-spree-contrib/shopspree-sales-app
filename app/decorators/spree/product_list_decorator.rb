class ProductListDecorator < Struct.new(:products, :taxonomies)
  def categories
    products.taxons.select_by { |taxon| taxon.taxonomy_id == @brand.id }
  end

  def brands
    products.taxons.where(taxonomy_id: @category.id)
  end

  def option_values
    products.option_types.includes(:option_values).inject(Hash.new([])) do |option_type_hash, option_type|
      option_type_hash[option_type.presentation] = option_type_hash[option_type.presentation]
                                                            .merge(option_type.option_values.map(&:presentation))
    end
  end

  def price
    products.
  end

  def category
    @category ||= Spree::Taxonomy.where(name: 'Category').last
  end

  def brand
    @brand ||= Spree::Taxonomy.where(name: 'Brand').last
  end
end
