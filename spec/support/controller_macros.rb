module ControllerMacros
  def login_user(factory_params = {}, type = :each)
    before(type) do
      @user = FactoryGirl.create(:user, factory_params)
      @auth_headers = @user.create_new_auth_token
      request.headers.merge! @auth_headers
    end
  end
end
