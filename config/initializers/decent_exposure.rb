# Patches for Rails 5 and decent exposure
module DecentExposure
  module Expose
    def protected_instance_variables
      protected_instance_methods
    end
  end
end
