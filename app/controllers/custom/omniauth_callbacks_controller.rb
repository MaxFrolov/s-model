class Custom::OmniauthCallbacksController < DeviseTokenAuth::OmniauthCallbacksController

  def assign_provider_attrs(user, auth_hash)
    name_parts = (auth_hash['info']['name'] || '').split(' ', 2)
    user.assign_attributes first_name: name_parts[0], last_name: name_parts[1], email: auth_hash['info']['email']
  end
end
