require 'rails_helper'

RSpec.describe Api::V1::UsersController, type: :controller do

  let(:valid_attributes) { attributes_for(:user) }

  let(:invalid_attributes) { attributes_for(:invalid_user) }

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
    @user = create(:user, email: 'email@email.com')
  end

  describe 'GET #show' do
    it 'returns a success response' do
      auth_token_to_headers @user
      get :show, params: { id: @user.to_param }

      expect(response.status).to eq 200
    end

    it 'allow to a authenticated see only your profile' do
      auth_token_to_headers @user

      other_user = create(:user)
      get :show, params: { id: other_user.id }

      expect(response.status).to eq 403
    end

    it 'returns a body with created reviews' do
      auth_token_to_headers @user
      review = create(:review, user_id: @user.id)
      get :show, params: { id: @user.to_param }
      reviews = JSON.parse(response.body)['reviews']

      expect(reviews.first['id']).to eq review.id
    end

    it 'returns a body without password' do
      get :show, params: { id: @user.to_param }
      expect(response.body.include?('password')).to be_falsey
    end

    context 'when no user is authenticated' do
      it 'requires to authenticated' do
        clear_auth_token
        get :show, params: { id: @user.to_param }
        expect(response.status).to eq(401)
      end
    end
  end

  describe 'PUT #update' do
    context 'with valid params' do
      it 'updates the requested user' do
        auth_token_to_headers @user
        put :update, params: {
          id: @user.to_param,
          user: attributes_for(:user, email: 'change@email.com')
        }

        @user.reload
        expect(@user.email).to eq('change@email.com')
      end

      it 'renders a JSON response with the user' do
        auth_token_to_headers @user
        put :update, params: {
          id: @user.to_param, user: valid_attributes
        }

        expect(response).to have_http_status(:ok)
      end
    end

    context 'with invalid params' do
      it 'does not change user\'s attributes' do
        auth_token_to_headers @user
        put :update, params: {
          id: @user,
          user: invalid_attributes
        }

        @user.reload
        expect(@user.email).to eq('email@email.com')
      end
    end

    context 'when no user is authenticated' do
      it 'requires to authenticated' do
        clear_auth_token
        put :update, params: {
          id: @user,
          user: valid_attributes
        }
        expect(response.status).to eq(401)
      end
    end
  end
end
