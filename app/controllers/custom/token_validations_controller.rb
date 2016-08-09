class Custom::TokenValidationsController < DeviseTokenAuth::TokenValidationsController

  def render_validate_token_success
    render json: UserSerializer.new(@resource), root: :resource
  end
end
