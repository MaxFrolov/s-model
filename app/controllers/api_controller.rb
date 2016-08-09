class ApiController < ActionController::API
  include ActionController::Helpers
  include ActionController::Serialization
  include DeviseTokenAuth::Concerns::SetUserByToken
  include Pundit
  include BaseControllerMethods

  after_action :verify_authorized
  before_action :authenticate_user!

  decent_configuration do
    strategy PunditAuthorizationStrategy
    permitted_attributes true
  end

  def permitted_attributes(record)
    params.require(:resource).permit(policy(record).permitted_attributes)
  end

  private

  rescue_from ActionController::ParameterMissing do |exception|
    render json: { errors: exception.message }, status: :bad_request
  end

  rescue_from ActiveRecord::RecordNotFound do |exception|
    render json: { errors: exception.message }, status: :not_found
  end

  rescue_from Pundit::NotAuthorizedError do
    render json: { errors: 'You are not authorized to access this action.' }, status: :forbidden
  end
end
