require 'rails_helper'

RSpec.describe 'TokenValidations', type: :request do
  let(:user) { create :user }


  describe 'POST create' do
    it 'should respond with success' do
      get '/api/auth/validate_token', params: {}, headers: user.create_new_auth_token
      expect(response).to be_success
    end

    it 'should return correct data' do
      get '/api/auth/validate_token', params: {}, headers: user.create_new_auth_token
      expect(json_response['resource']).to eq serialized(user)['resource']
    end
  end
end
