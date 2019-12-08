module Api::V1
  class RegistrationsController < Devise::RegistrationsController
    include ActionController::MimeResponds
    respond_to :json

    acts_as_token_authentication_handler_for User

    skip_before_action :authenticate_entity_from_token!, raise: false, only: [:create]
    skip_before_action :authenticate_entity!, raise: false, only: [:create]

    skip_before_action :authenticate_scope!
    append_before_action :authenticate_scope!, only: [:destroy]

    def create
      build_resource(sign_up_params)

      if resource.save
        sign_up(resource_name, resource)
        render json: resource, status: :created
      else
        clean_up_passwords resource
        render json: resource.errors.full_messages, status: :unprocessable_entity
      end
    end

    def destroy
      resource.deactivated_at = DateTime.now
      resource.save!
      Devise.sign_out_all_scopes ? sign_out : sign_out(resource_name)
    end

    private

    def sign_up_params
      params.fetch(:user).permit(%i[password email])
    end
  end
end