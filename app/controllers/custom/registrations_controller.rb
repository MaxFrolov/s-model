class Custom::RegistrationsController < DeviseTokenAuth::RegistrationsController

  def render_create_success
    render_resource_data(@resource)
  end

  def render_create_error
    render_resource_errors(@resource)
  end

  def render_update_success
    render_resource_data(@resource)
  end

  def render_update_error
    render_resource_errors(@resource)
  end
end
