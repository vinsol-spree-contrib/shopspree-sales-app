Spree::Api::Ams::UsersController.class_eval do

  def token
    if @user = Spree.user_class.find_for_database_authentication(login: user_params[:email])
      if user_params[:password].present?
        authenticate_with_password
      elsif user_params[:authentication_attributes][:uid].present?
        authenticate_with_uid
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
      render_with_serializer
    else
      invalid_resource!(@user)
    end
  end

  private

    def user_params
      params.require(:user).permit(:email, :password, :full_name, 
                                   authentication_attributes: [:provider, :uid, :profile_pic_url])
    end

    def render_with_serializer
      render json: @user, serializer: Spree::UserSerializer
    end

    def authenticate_with_uid
      if @user = Spree.user_class.find_for_social_authentication(uid: user_params[:authentication_attributes][:uid],
                                                                 provider: user_params[:authentication_attributes][:provider])
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