module Api::V1
  class LocationsController < BaseController
    before_action :set_location, only: %i[show update destroy]
    before_action :set_user, only: [:create]
    # before_action :authenticate_user

    def index
      @locations = Location.all

      render json: @locations
    end

    def show
      render json: @location
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

    def update
      if @location.update(location_params)
        render json: @location
      else
        render json: @location.errors, status: :unprocessable_entity
      end
    end

    def destroy
      @location.destroy
    end

    private

    def set_location
      @location = Location.find(params[:id])
    end

    def set_user
      @user = User.find_by_id params[:user_id]
    end

    # Only allow a trusted parameter "white list" through.
    def location_params
      params.require(:location).permit(:latitude, :longitude, :name)
    end
  end
end
