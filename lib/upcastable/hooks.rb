module Upcastable
  module Hooks
    def self.extended(base)
      if base < Object
        raise ArgumentError, 'extended class or module must be an ancestor of Object'
      end

      base.class_eval do
        class << self
          alias_method :__upcastable_orig_method_added, :method_added

          private

            def method_added(name)
              return unless Object <= self
              ::Upcastable::UpcastedObject.define_delegate_method(name)
              __upcastable_orig_method_added(name)
            end
        end
      end
    end
  end
end
