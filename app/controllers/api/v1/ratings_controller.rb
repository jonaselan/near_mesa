module Api::V1
  class RatingsController < ApplicationController
    def index
      @ratings = Rating.all

      render json: @ratings
    end

    def create
      @rating = Rating.new(rating_params)

      if @rating.save
        render json: @rating, status: :created, location: @rating
      else
        render json: @rating.errors, status: :unprocessable_entity
      end
    end

    private

    # Only allow a trusted parameter "white list" through.
    def rating_params
      params.require(:rating).permit(:user, :location_id, :value)
    end
  end
end
