require 'rails_helper'

RSpec.describe Api::V1::RatingsController, type: :controller do
  let(:valid_attributes) { attributes_for(:rating) }

  let(:invalid_attributes) { attributes_for(:rating) }

  before :each do
    @user = create(:user)
  end

  describe 'GET #index' do
    it 'returns a success response' do
      rating = create(:rating)
      get :index, params: {}
      expect(response).to be_successful
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new Rating' do
        expect do
          post :create, params: { user_id: @user.id, rating: valid_attributes }
        end.to change(Rating, :count).by(1)
      end

      it 'renders a JSON response with the new rating' do
        post :create, params: { user_id: @user.id, rating: valid_attributes }
        expect(response).to have_http_status(:created)
        expect(response.content_type).to eq('application/json')
        expect(response.location).to eq(rating_url(Rating.last))
      end
    end

    context 'with invalid params' do
      it 'renders a JSON response with errors for the new rating' do
        post :create, params: { user_id: @user.id, rating: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/json')
      end
    end
  end
end
