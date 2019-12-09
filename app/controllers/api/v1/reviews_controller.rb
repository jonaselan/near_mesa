module Api::V1
  class ReviewsController < ApplicationController
    before_action :authenticate_user!

    def index
      @reviews = Review.where(location_id: params[:location_id])

      render json: @reviews
    end

    def create
      @review = current_user.reviews.build(review_params.merge(location_id: params[:location_id]))

      if @review.save
        render json: @review, status: :created
      else
        render json: @review.errors, status: :unprocessable_entity
      end
    end

    private

      def review_params
        params.require(:review).permit(:comment, :rating, :location_id, :user_id)
      end
  end

end