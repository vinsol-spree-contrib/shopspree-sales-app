Spree::Api::Ams::TaxonomiesController.class_eval do
  def index
    render json: Spree::TaxonomiesSerializer.new(taxonomies), status: 200
  end
end
