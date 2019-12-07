# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::LocationsController, type: :controller do
  let(:valid_attributes) { attributes_for(:location) }

  let(:invalid_attributes) { attributes_for(:invalid_location) }

  before :each do
    @user = create(:user)
  end

  # describe 'GET #index' do
  #   it 'returns a success response' do
  #     location = Location.create! valid_attributes
  #     get :index, params: {}
  #     expect(response).to be_successful
  #   end
  # end

  # describe "GET #show" do
  #   it "returns a success response" do
  #     location = Location.create! valid_attributes
  #     get :show, params: {id: location.to_param}
  #     expect(response).to be_successful
  #   end
  # end

  describe 'POST #create' do
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

  # describe "PUT #update" do
  #   context "with valid params" do
  #     let(:new_attributes) {
  #       skip("Add a hash of attributes valid for your model")
  #     }

  #     it "updates the requested location" do
  #       location = Location.create! valid_attributes
  #       put :update, params: {id: location.to_param, location: new_attributes}
  #       location.reload
  #       skip("Add assertions for updated state")
  #     end

  #     it "renders a JSON response with the location" do
  #       location = Location.create! valid_attributes

  #       put :update, params: {id: location.to_param, location: valid_attributes}
  #       expect(response).to have_http_status(:ok)

  #     end
  #   end

  #   context "with invalid params" do
  #     it "renders a JSON response with errors for the location" do
  #       location = Location.create! valid_attributes

  #       put :update, params: {id: location.to_param, location: invalid_attributes}
  #       expect(response).to have_http_status(:unprocessable_entity)

  #     end
  #   end
  # end

  # describe "DELETE #destroy" do
  #   it "destroys the requested location" do
  #     location = Location.create! valid_attributes
  #     expect {
  #       delete :destroy, params: {id: location.to_param}
  #     }.to change(Location, :count).by(-1)
  #   end
  # end
end
