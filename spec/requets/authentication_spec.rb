require 'rails_helper'

def response_body
  JSON.parse(response.body)
end

RSpec.describe 'POST /users/login', type: :request do
  let(:user) { create(:user) }
  let(:url) { '/users/login' }
  let(:params) do
    {
      user: {
        email: user.email,
        password: user.password
      }
    }
  end
  let(:invalid_params) do
    {
      user: {
        email: 'wrong@email.com',
        password: 'wrong_password'
      }
    }
  end

  context 'when params are correct' do
    before do
      post url, params: params
    end

    it 'returns 200' do
      expect(response).to have_http_status(200)
    end

    it 'returns token in body' do
      expect(response_body['authentication_token']).to_not be_nil
    end

    it 'returns valid token' do
      user.reload
      expect(user.authentication_token).to eq(response_body['authentication_token'])
    end
  end

  context 'when login params are incorrect' do
    before do
      post url, { params: invalid_params, headers: { accept: 'application/json' } }
    end

    it 'returns unathorized status' do
      expect(response.status).to eq 401
    end
  end
end

RSpec.describe 'DELETE /users/logout', type: :request do
  let(:user) { create(:user) }
  let(:url) { '/users/logout' }

  it 'returns 204, no content' do
    delete url, {
      headers: {
        accept: 'application/json',
        'X-User-Email': user.email,
        'X-User-Token': user.authentication_token
      }
    }
    expect(response).to have_http_status(204)
  end

  it 'reset token from current user' do
    delete url, {
      headers: {
        accept: 'application/json',
        'X-User-Email': user.email,
        'X-User-Token': user.authentication_token
      }
    }
    revoked_token = user.authentication_token
    user.reload
    expect(user.authentication_token).to_not eq(revoked_token)
  end
end