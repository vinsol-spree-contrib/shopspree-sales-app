Spree::Api::BaseController.class_eval do

  private

    def load_ams_user
      unless @user = Spree.user_class.find_by(spree_api_key: params[:token])
        render json: { errors: 'User not found' }, status: 404
      end
    end
end
