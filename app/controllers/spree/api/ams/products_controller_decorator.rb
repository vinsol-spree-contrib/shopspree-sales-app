Spree::Api::Ams::ProductsController.class_eval do
  def show
    @product = Spree::Product.find_by(id: params[:id])
    if @product 
      @product.review_limit = params[:review_limit]
      render json: @product, serializer: Spree::ProductSerializer
    else
      render json: { errors: 'Product not found' }, status: 404
    end
  end

  def index
    if params[:ids]
      @product_scope = product_scope.where(id: params[:ids].split(",").flatten)
    else
      @product_scope = product_scope.ransack(params[:q]).result
    end

    @products = @product_scope.distinct.page(params[:page]).per(params[:per_page])
    expires_in 15.minutes, :public => true
    headers['Surrogate-Control'] = "max-age=#{15.minutes}"
    render json: Spree::ProductListDecorator.new(@products, @product_scope), serializer: Spree::ProductListSerializer
  end
end