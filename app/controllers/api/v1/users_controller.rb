module Api::V1
  class UsersController < ApplicationController
    before_action :authenticate_user!
    before_action :set_user, only: %i[show]

    def show
      if @user != current_user
        return render json: {
            error: 'You are not allowed to perform this action.'
          }, status: :forbidden
      end

      render json: @user.to_json(include: [:reviews])
    end

    def update
      if current_user.update(user_params)
        render json: current_user
      else
        render json: current_user.errors, status: :unprocessable_entity
      end
    end

    private

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
