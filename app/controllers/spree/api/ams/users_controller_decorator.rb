Spree::Api::Ams::UsersController.class_eval do

  def token
    if @user = Spree.user_class.find_for_database_authentication(login: user_params[:email])
      if @user.valid_password?(user_params[:password]) || @user.valid_uid?(user_params[:uid])
        render json: @user, serializer: Spree::UserSerializer
      else
        render json: {
          error: "Invalid resource. Please fix errors and try again.",
          errors: {
            password: ["incorrect"]
          }
        }, status: 422
      end
    else
      render json: {
        error: "Invalid resource. Please fix errors and try again.",
        errors: {
          email: ["not found"]
        }
      }, status: 422
    end
  end

  def create
    authorize! :create, Spree.user_class
    @user = Spree.user_class.new(user_params)
    if @user.save
      @user.generate_spree_api_key! unless @user.spree_api_key
      render json: @user, serializer: Spree::UserSerializer
    else
      invalid_resource!(@user)
    end
  end

  private

    def user_params
      params.require(:user).permit(:email, :password, :login_type, :full_name, :uid, :profile_pic_url)
    end

end