require 'rails_helper'

RSpec.describe Api::V1::ReviewsController, type: :controller do
  let(:valid_attributes) { attributes_for(:review) }

  let(:invalid_attributes) { attributes_for(:invalid_review) }

  before :each do
    @user = create(:user)
    @location = create(:location)
  end

  describe 'GET #index' do
    it 'returns a success response' do
      auth_token_to_headers @user

      create(:review)
      get :index, params: { location_id: @location.id }
      expect(response).to be_successful
    end

    context 'when no user is authenticated' do
      it 'requires to authenticated' do
        clear_auth_token
        get :index, params: { location_id: @location.id }
        expect(response.status).to eq(401)
      end
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new Review' do
        auth_token_to_headers @user
        expect do
          post :create, params: {
            location_id: @location.id,
            review: valid_attributes
          }
        end.to change(Review, :count).by(1)
        review = Review.last
        expect(review.user).to eq @user
        expect(review.location).to eq @location
      end

      it 'renders a JSON response with the new review' do
        auth_token_to_headers @user
        post :create, params: {
          location_id: @location.id,
          review: valid_attributes.merge(location_id: @location.id)
        }

        expect(response).to have_http_status(:created)
      end
    end

    context 'with invalid params' do
      it 'renders a JSON response with errors for the new review' do
        auth_token_to_headers @user

        post :create, params: { location_id: @location.id, review: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    context 'when no user is authenticated' do
      it 'requires to authenticated' do
        clear_auth_token
        post :create, params: { location_id: @location.id, review: valid_attributes }
        expect(response.status).to eq(401)
      end
    end
  end
end
