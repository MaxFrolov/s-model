require 'rails_helper'

RSpec.describe 'Session', type: :request do
  let(:password) { Devise.friendly_token.first(8) }
  let(:user) { create(:user, password: password, password_confirmation: password) }

  describe 'POST create' do
    it 'should respond with success' do
      post '/api/auth/sign_in', params: {email: user.email, password: password}
      expect(response).to be_success
    end

    it 'should return user token' do
      post '/api/auth/sign_in', params: {email: user.email, password: password}
      expect(response.headers).to include('access-token')
    end

    it 'should return correct data' do
      post '/api/auth/sign_in', params: {email: user.email, password: password}
      expect(json_response['resource']).to eq serialized(user)['resource']
    end
  end
end
