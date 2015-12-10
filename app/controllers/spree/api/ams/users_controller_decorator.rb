Spree::Api::Ams::UsersController.class_eval do

  def token
    if @user = Spree.user_class.find_for_database_authentication(login: user_params[:email])
      authenticate_api_user
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
    set_api_user
    if @user.update_attributes(user_params)
      render_with_serializer
    else
      invalid_resource!(@user)
    end
  end

  private

    def user_params
      params.require(:user).permit(:email, :password, :full_name, :phone, authentications_attributes: [:uid, :provider, :profile_pic_url])
    end

    def render_with_serializer
      render json: @user, serializer: Spree::UserSerializer
    end

    def set_api_user
      if user_params[:authentications_attributes].present?
        @user = Spree.user_class.find_or_initialize_by(email: user_params[:email])
      else
        @user = Spree.user_class.new
      end
    end

    def authenticate_api_user
      if user_params[:password].present?
        authenticate_with_password
      elsif params[:user][:uid].present?
        authenticate_with_uid
      end
    end

    def authenticate_with_uid
      if @user.valid_social_login?(params[:user][:uid], params[:user][:provider])
        render_with_serializer
      else
        render json: {
          errors: 'Invalid user'
        }, status: 422
      end
    end

    def authenticate_with_password
      if @user.valid_password?(user_params[:password])
        render_with_serializer
      else
        render json: {
          error: "Invalid resource. Please fix errors and try again.",
          errors: {
            password: ["incorrect"]
          }
        }, status: 422
      end
    end

end
