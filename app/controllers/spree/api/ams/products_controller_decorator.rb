Spree::Api::Ams::ProductsController.class_eval do
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