module Api::V1
  class UsersController < ApplicationController
    before_action :set_user, only: %i[show]

    # GET /users/1
    def show
      render json: @user
    end

    # PATCH/PUT /users/1
    def update
      if @user.update(user_params)
        render json: @user
      else
        render json: @user.errors, status: :unprocessable_entity
      end
    end

    private

    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User
              .where(['id = ?', params[:id]])
              .select('id, email')
              .first
    end

    # Only allow a trusted parameter "white list" through.
    def user_params
      params.require(:user).permit(:email, :password)
    end
  end
end
