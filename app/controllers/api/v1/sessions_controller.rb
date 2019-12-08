module Api::V1
  class SessionsController < Devise::SessionsController
    include ActionController::MimeResponds
    acts_as_token_authentication_handler_for User, fallback_to_devise: false

    skip_before_action :authenticate_entity_from_token!, only: [:create], raise: false
    skip_before_action :authenticate_entity!, only: [:create], raise: false
    skip_before_action :verify_signed_out_user, only: [:destroy]

    # reset token
    def create
      allow_params_authentication!
      self.resource = warden.authenticate!(auth_options)

      reset_token resource
      render json: resource
    end

    def destroy
      warden.authenticate!
      reset_token current_user
    end

    private

    def sign_in_params
      params.fetch(:user).permit(%i[password email])
    end

    def reset_token(resource)
      resource.authentication_token = nil
      resource.save!
    end
  end

end