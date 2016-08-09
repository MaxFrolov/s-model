class Custom::SessionsController < DeviseTokenAuth::SessionsController

  def render_create_success
    render json: UserSerializer.new(@resource), root: :resource
  end
end
