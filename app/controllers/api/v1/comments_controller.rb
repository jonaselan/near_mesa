module Api::V1
  class CommentsController < ApplicationController

    def index
      @comments = Comment.all

      render json: @comments
    end

    def create
      # TODO: verificar também se ele é igual ao usuário logado
      unless @user
        return render json: { error: 'User don\'t exist' }, status: :not_found
      end

      @comment = @user.comments.build(location_params)

      # @comment = Comment.new(comment_params)

      if @comment.save
        render json: @comment, status: :created, location: @comment
      else
        render json: @comment.errors, status: :unprocessable_entity
      end
    end

    private

      def comment_params
        params.require(:comment).permit(:body, :location_id, :user_id)
      end
  end

end