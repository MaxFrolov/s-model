require 'rails_helper'

RSpec.describe 'Passwords', type: :request do
  describe 'Send a password reset confirmation email' do
    let(:user) { create(:user) }

    subject { post '/api/auth/password', params: {email: user.email} }

    it 'should respond with success' do
      subject
      expect(response).to be_success
    end

    it 'should send email' do
      user
      expect { subject }.to change(MandrillMailer.deliveries, :count).by 1
    end

    it 'should send reset password email' do
      subject
      expect(MandrillMailer.deliveries.last['template_name']).to eq 'reset-password-instructions' # 'user-welcome'
    end
  end

  describe 'Verify user by password reset token' do
    let(:user) { create(:user) }

    before do
      raw, enc = Devise.token_generator.generate(User, :reset_password_token)
      @user = create(:user, reset_password_token: enc, reset_password_sent_at: Time.now.utc)
      @token = raw
    end

    subject { get '/api/auth/password/edit', params: {reset_password_token: @token, redirect_url: 'http://example.com/'} }

    it 'should respond with redirect' do
      subject
      expect(response).to be_redirect
    end

    it "should change user's reset token" do
      subject
      expect(@user.reload.reset_password_token).to eq @token
    end
  end

  describe "Change user's passwords" do
    let(:user) { create(:user, password: 'password') }

    before do
      @auth_headers = user.create_new_auth_token
    end

    it 'should respond with success' do
      put '/api/auth/password', params: {password: 'new-pass', password_confirmation: 'new-pass'}, headers: @auth_headers
      expect(response).to be_success
    end

    context 'wrong params' do
      it 'should require password confirmation' do
        put '/api/auth/password', params: {password: 'new-pass'}, headers: @auth_headers
        expect(response).to be_unprocessable
      end

      it 'should require password confirmation to match new password' do
        put '/api/auth/password', params: {password: 'new-pass', password_confirmation: 'other-pass'}, headers: @auth_headers
        expect(response).to be_unprocessable
      end
    end
  end
end
