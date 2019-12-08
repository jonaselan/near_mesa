require 'rails_helper'

RSpec.describe Api::V1::ReviewsController, type: :controller do
  let(:valid_attributes) { attributes_for(:review) }

  let(:invalid_attributes) { attributes_for(:invalid_review) }

  def auth_token_to_headers(user)
    default_headers
    @request.headers['X-User-Email'] = user.email.to_s
    @request.headers['X-User-Token'] = user.authentication_token.to_s
  end

  def clear_auth_token
    default_headers
    @request.headers['X-User-Email'] = nil
    @request.headers['X-User-Token'] = nil
  end

  def default_headers
    @request.headers['Accept'] = 'application/json'
    @request.headers['Content-Type'] = 'application/json'
  end

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
            comment: valid_attributes.merge(location_id: @location.id)
          }
        end.to change(Comment, :count).by(1)
        comment = Comment.last
        expect(comment.user).to eq @user
        expect(comment.location).to eq @location
      end

      it 'renders a JSON response with the new comment' do
        auth_token_to_headers @user
        post :create, params: {
          location_id: @location.id,
          comment: valid_attributes.merge(location_id: @location.id)
        }

        expect(response).to have_http_status(:created)
      end
    end

    context 'with invalid params' do
      it 'renders a JSON response with errors for the new comment' do
        auth_token_to_headers @user

        post :create, params: { location_id: @location.id, comment: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    context 'when no user is authenticated' do
      it 'requires to authenticated' do
        clear_auth_token
        post :create, params: { location_id: @location.id, comment: valid_attributes }
        expect(response.status).to eq(401)
      end
    end
  end
end
