class PunditAuthorizationStrategy < DecentExposure::StrongParametersStrategy
  delegate :authorize, :policy_scope, :permitted_attributes, to: :controller

  def attributes
    if options[:permitted_attributes]
      @attributes = permitted_attributes(model)
    else
      super
    end
  end

  def resource
    super.tap { |r| authorize r }
  end
end
