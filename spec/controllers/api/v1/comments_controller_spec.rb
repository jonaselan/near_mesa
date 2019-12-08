require 'rails_helper'

RSpec.describe Api::V1::CommentsController, type: :controller do

  let(:valid_attributes) { attributes_for(:comment) }

  let(:invalid_attributes) { attributes_for(:invalid_comment) }

  describe "GET #index" do
    it "returns a success response" do
      comment = create(:comment)

      get :index, params: {}
      expect(response).to be_successful
    end
  end

  describe "POST #create" do
    before :each do
      @user = create(:user)
    end

    context "with valid params" do
      it "creates a new Comment" do
        expect {
          post :create, params: { user_id: @user.id, comment: valid_attributes }
        }.to change(Comment, :count).by(1)

        expect(Comment.last.user).to eq @user
      end

      it "renders a JSON response with the new comment" do
        post :create, params: { user_id: @user.id, comment: valid_attributes }

        expect(response).to have_http_status(:created)
      end
    end

    # context "with invalid params" do
    #   it "renders a JSON response with errors for the new comment" do

    #     post :create, params: {comment: invalid_attributes}
    #     expect(response).to have_http_status(:unprocessable_entity)
    #     expect(response.content_type).to eq('application/json')
    #   end
    # end
  end
end
