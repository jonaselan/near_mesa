module Api::V1
  class LocationsController < BaseController
    before_action :set_user, only: [:create]
    # before_action :authenticate_user

    def index
      begin
        @locations = LocationOrder.new(params).order
      rescue => e
        return render json: { error: e.message }, status: :unprocessable_entity
      end

      render json: @locations
    end

    def create
      # TODO: verificar também se ele é igual ao usuário logado
      unless @user
        return render json: { error: 'User don\'t exist' }, status: :not_found
      end

      @location = @user.locations.create(location_params)

      if @location.save
        render json: @location, status: :created
      else
        render json: @location.errors, status: :unprocessable_entity
      end
    end

    private

    def set_user
      @user = User.find_by_id params[:user_id]
    end

    def location_params
      params.require(:location).permit(:latitude, :longitude, :name)
    end
  end
end
