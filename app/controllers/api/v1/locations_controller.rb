module Api::V1
  class LocationsController < ApplicationController
    before_action :authenticate_user!

    def index
      begin
        @locations = LocationOrder.new(params).order
      rescue => e
        return render json: { error: e.message }, status: :unprocessable_entity
      end

      render json: @locations
    end

    def create
      @location = current_user.locations.create(location_params)

      if @location.save
        render json: @location, status: :created
      else
        render json: @location.errors, status: :unprocessable_entity
      end
    end

    private

    def location_params
      params.require(:location).permit(:latitude, :longitude, :name)
    end
  end
end
