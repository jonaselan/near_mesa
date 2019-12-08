require 'rails_helper'

RSpec.describe Api::V1::LocationsController, type: :controller do
  let(:valid_attributes) { attributes_for(:location) }

  let(:invalid_attributes) { attributes_for(:invalid_location) }

  describe 'GET #index' do
    it 'returns a success response' do
      location = create(:location)
      get :index, params: {}
      expect(response).to be_successful
    end
  end

  describe 'POST #create' do
    before :each do
      @user = create(:user)
    end

    context 'with valid params' do
      it 'creates a new Location and related with the user' do
        expect do
          post :create, params: { user_id: @user.id, location: valid_attributes }
        end.to change(Location, :count).by(1)

        expect(Location.last.user).to eq @user
      end

      it 'renders a JSON response with the new location' do
        post :create, params: { user_id: @user.id, location: valid_attributes }

        expect(response).to have_http_status(:created)
      end
    end

    context 'with invalid params' do
      it 'renders a JSON response with errors for the new location' do
        post :create, params: { user_id: @user.id, location: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'renders a error when the user don\'t exist' do
        post :create, params: { user_id: 0, location: valid_attributes }

        expect(response.body).to include("User don't exist")
        expect(response).to have_http_status(:not_found)
      end
    end
  end
end
