module Validation
  # Adds default validation functionality.
  module Base

    def self.included(base)
      super

      base.send(:include, Virtus.model(required: false))
      base.send(:include, ActiveModel::Validations)
      base.send(:include, ActiveModel::Validations::Callbacks)

    end
  end
end