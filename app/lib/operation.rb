module Operation

  class Error < StandardError
    attr_reader :errors
    def initialize(errors = {})
      @errors = errors
      super("Internal server error")
    end
  end

  # Adds default operation functionality.
  module Base

    # validation form object
    attr_reader :form
    # operation model object
    attr_reader :model
    # operation params
    attr_reader :params
    # operation perform errors
    # attr_reader :errors
    # operation perform result
    attr_reader :result

    # Creates validation {form} object.
    # @param original_params [Hash] list of params for operation
    def initialize(original_params = {})
      @performed = false
      if original_params.is_a?(ActionController::Parameters)
        original_params = original_params.to_unsafe_h
      end
      @params = original_params.dup.with_indifferent_access.deep_transform_keys { |key| key.to_s.underscore }
      @errors = {}

      pp params
      if validator_klass
        @form = validator_klass.new(params)
        @params = form.attributes.slice(*params.keys.map(&:to_sym)).with_indifferent_access
      end
    end

    def process(args = {})
      @start = Time.zone.now.to_f
      with_validation(args) do
        begin
          @result = perform
        rescue Operation::Error => e
          e.errors.each_pair do |k,v|
            add_error(k,v)
          end
          @result = nil
        rescue => e
          if Rails.env.development? || Rails.env.test? || true
            pp e.backtrace
            pp e.message
          end
          @result = nil
          add_error(500, 'Internal server error') if @errors.empty?
        end
        @performed = true
        result
      end
    end

    def perform
    end

    def add_error(code, message)
      @errors[code] = message
    end

    def add_error!(code, message = nil)
      add_error(code, message)
      fail Operation::Error.new( @errors )
    end

    def errors
      @errors.merge form.errors.messages
    end

    protected

    def validator_klass
      self.class.name.sub("::Action::","::Validation::").safe_constantize
    end


    def with_validation(args = {}, &block)
      return false unless block_given?
      start = Time.zone.now.to_f
      if !form || !form.valid?  
        return false
      end
      yield
    end

    def with_transaction(&block)
      ActiveRecord::Base.transaction { yield || false }
    end


  end
end
