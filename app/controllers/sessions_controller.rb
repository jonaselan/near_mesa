class SessionsController < Devise::SessionsController
  def create
    user = User.find_by_email(sign_in_params[:email])
    user = nil
    if user&.valid_password?(sign_in_params[:password])
      token = JWT.encode({ id: user.id }, Rails.application.secrets.secret_key_base, 'none')

      render json: {
        token: token,
        user: user
      }, status: :ok
    else
      render json: {
        errors: {
          'email or password' => ['is invalid']
        }
      }, status: :unprocessable_entity
    end
  end
end
