Spree::Api::Ams::ProductsController.class_eval do
  include ProductSearch

  def show
    @product = Spree::Product.find_by(id: params[:id])
    if @product
      render json: serialized_hash
    else
      render json: { errors: 'Product not found' }, status: 404
    end
  end

  def index
    if params[:ids]
      @product_scope = product_scope.where(id: params[:ids].split(",").flatten)
      @products = @product_scope.distinct.page(params[:page]).per(params[:per_page])
    else
      @products = product_search_results
      @product_scope = Kaminari.paginate_array(product_search_results).page(params[:page]).per(params[:per_page])
    end
    render json: { products: ActiveModel::ArraySerializer.new(@product_scope, each_serializer: Spree::ProductSerializer), filters: aggregations }
  end

  private
    def serialized_hash
      {
        product: Spree::ProductSerializer.new(@product),
        reviews: ActiveModel::ArraySerializer.new(@product.reviews.approved.ratings_with_reviews.first(params[:per_page] || 5), each_serializer: Spree::ReviewSerializer)
      }
    end
end
