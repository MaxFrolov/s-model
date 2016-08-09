require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe 'GET user' do
    let(:current_user) { create(:user) }
    let(:other_user) { create(:user) }

    context 'logged in user' do
      before do
        @auth_headers = current_user.create_new_auth_token
        request.headers.merge!(@auth_headers)
      end

      it 'should respond with success for current user' do
        get :show, params: {id: current_user.id}
        expect(response).to be_success
      end

      it 'should response with forbidden for other users' do
        get :show, params: {id: other_user.id}
        expect(response).to be_forbidden
      end
    end

    it 'should respond with unauthorized for guests' do
      get :show, params: {id: current_user.id}
      expect(response).to be_unauthorized
    end
  end

  describe 'PUT user' do
    context 'logged in user' do
      login_user(first_name: 'User', last_name: 'Test', email: 'user@example.com')

      context 'current user update' do
        it 'should respond with success' do
          put :update, params: {id: @user.id, resource: {first_name: 'John', last_name: 'Doe'}}
          expect(response).to be_success
        end

        it "should change user's attributes" do
          put :update, params: {id: @user.id, resource: {first_name: 'John', last_name: 'Doe'}}
          @user.reload
          expect([@user.first_name, @user.last_name]).to eq %w{John Doe}
        end

        it "should change user's email and uid" do
          put :update, params: {id: @user.id, resource: {email: 'new-user@example.com'}}
          @user.reload
          expect([@user.email, @user.uid]).to eq %w{new-user@example.com new-user@example.com}
        end

        context 'current user with oauth integration' do
          login_user provider: 'facebook', uid: 'abc123', email: 'user@example.com'

          it "should change user's email but not uid" do
            put :update, params: {id: @user.id, resource: {email: 'new-user@example.com'}}
            @user.reload
            expect([@user.email, @user.uid]).to eq %w{new-user@example.com abc123}
          end
        end
      end

      context 'other user update' do
        let(:other_user) { create(:user) }

        it 'should response with forbidden' do
          put :update, params: {id: other_user.id, resource: {first_name: 'Evil'}}
          expect(response).to be_forbidden
        end
      end
    end

    context 'guest user' do
      let(:other_user) { create(:user) }

      it 'should respond with unauthorized' do
        put :update, params: {id: other_user.id, resource: {first_name: 'Evil'}}
        expect(response).to be_unauthorized
      end
    end
  end
end
