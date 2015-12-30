Spree::Api::Ams::OrdersController.class_eval do
  def mine
    if current_api_user.persisted?
      @orders = current_api_user.orders.where(state: 'complete').reverse_chronological.ransack(params[:q]).result.page(params[:page]).per(params[:per_page])
      render json: Spree::MyOrdersSerializer.new(@orders, current_page: params[:page]), status: 200
    else
      render "spree/api/errors/unauthorized", status: :unauthorized
    end
  end
end
