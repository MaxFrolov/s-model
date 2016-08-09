require 'rails_helper'

RSpec.describe 'Registration', type: :request do
  describe 'POST create' do
    let(:password) { Devise.friendly_token.first(8) }
    let(:params) { attributes_for(:user) }

    subject { post '/api/auth', params: params }

    it 'should respond with success' do
      subject
      expect(response).to be_success
    end

    it 'should creates new user' do
      expect { subject }.to change(User, :count).by 1
    end

    it 'should return correct data' do
      subject
      expect(json_response['resource']).to eq serialized(User.last)['resource']
    end

    it 'should send email' do
      expect { subject }.to change(MandrillMailer.deliveries, :count).by 1
    end

    it 'should send welcome email' do
      subject
      expect(MandrillMailer.deliveries.last['template_name']).to eq 'user-welcome'
    end
  end

  describe 'POST update' do
    let(:user) { create :user }
    let(:params) { {email: Faker::Internet.email, first_name: Faker::Name.first_name, last_name: Faker::Name.last_name} }

    subject! { put '/api/auth', params: params, headers: user.create_new_auth_token }

    it { expect(user.reload.first_name).to eq params[:first_name] }
    it { expect(user.reload.email).to eq params[:email] }
  end
end
