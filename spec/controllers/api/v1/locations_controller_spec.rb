require 'rails_helper'

RSpec.describe Api::V1::LocationsController, type: :controller do
  let(:valid_attributes) { attributes_for(:location) }

  let(:invalid_attributes) { attributes_for(:invalid_location) }

  before :each do
    @user = create(:user)
  end

  describe 'GET #index' do
    it 'returns a success response' do
      location = create(:location)

      auth_token_to_headers @user
      get :index, params: {}
      expect(response.status).to eq 200
    end

    context 'when no user is authenticated' do
      it 'requires to authenticated' do
        clear_auth_token
        get :index
        expect(response.status).to eq(401)
      end
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new Location and related with the user' do
        auth_token_to_headers @user

        expect do
          post :create, params: { location: valid_attributes }
        end.to change(Location, :count).by(1)

        expect(Location.last.user).to eq @user
      end

      it 'renders a JSON response with the new location' do
        auth_token_to_headers @user

        post :create, params: { location: valid_attributes }

        expect(response).to have_http_status(:created)
      end
    end

    context 'with invalid params' do
      it 'renders a JSON response with errors for the new location' do
        auth_token_to_headers @user

        post :create, params: { location: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    context 'when no user is authenticated' do
      it 'requires to authenticated' do
        clear_auth_token
        post :create, params: { location: valid_attributes }
        expect(response.status).to eq(401)
      end
    end
  end
end
