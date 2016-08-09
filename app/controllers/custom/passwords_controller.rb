class Custom::PasswordsController < DeviseTokenAuth::PasswordsController

  def render_create_success
    render_resource_data(@resource)
  end

  def render_update_success
    render_resource_data(@resource)
  end
end
