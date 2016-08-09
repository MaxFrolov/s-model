class UsersController < ApiController
  expose :user

  def show
    render_resource_data user
  end

  def update
    user.update permitted_attributes(current_user)
    render_resource_or_errors user
  end
end
