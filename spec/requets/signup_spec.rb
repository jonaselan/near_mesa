require 'rails_helper'
require 'json'

RSpec.describe 'POST /users/register', type: :request do
  let(:url) { '/users/register' }
  let(:email) { 'user@example.com' }
  let(:password) { 'password' }
  let(:params) do
    {
      user: {
        email: email,
        password: password
      }
    }
  end

  def response_body
    JSON.parse(response.body)
  end

  context 'when user is unauthenticated' do
    before { post url, params: params }

    it 'returns 201' do
      expect(response.status).to eq 201
    end

    it 'returns a new user' do
      expect(response_body['email']).to include(email)
    end

    it 'returns token in body' do
      expect(response_body['authentication_token']).to_not be_nil
    end
  end

  context 'when user already exists' do
    before do
      create :user, email: email
      post url, params: params
    end

    it 'returns bad request status' do
      expect(response.status).to eq 422
    end

    it 'returns validation errors' do
      expect(response.body).to include('Email has already been taken')
    end
  end
end