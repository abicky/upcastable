module Upcastable
  class UpcastedObject
    def self.define_delegate_method(m)
      define_method(m) do |*args, &block|
        @object.send(m, *args, &block)
      end
    end

    def initialize(object, ancestor, base = object.class)
      unless base <= ancestor
        raise ArgumentError, "#{ancestor} is not an ancestor of #{base}"
      end
      @object   = object
      @ancestor = ancestor
    end

    (instance_methods - [:public_send, :clone]).each do |m|
      define_delegate_method(m)
    end

    def initialize_clone(other)
      @object = @object.clone
    end

    def send(m, *args, &block)
      unless @ancestor.method_defined?(m) && @ancestor.private_method_defined?(m)
        raise NoMethodError, "`#{m}' is not defined in #{@ancestor}"
      end
      @object.send(m, *args, &block)
    end

    def respond_to?(m, private = false)
      if private
        @ancestor.private_method_defined?(m) || @ancestor.method_defined?(m)
      else
        @ancestor.method_defined?(m)
      end
    end

    def upcast_to(ancestor)
      return self if ancestor == @ancestor
      UpcastedObject.new(@object, ancestor, @ancestor)
    end

    def upcasting
      @ancestor
    end

    def upcasted?
      true
    end

    def downcast
      @object
    end

    def method_missing(m, *args, &block)
      unless @ancestor.method_defined?(m)
        raise NoMethodError, "`#{m}' is not defined in #{@ancestor}"
      end
      @object.send(m, *args, &block)
    end
  end
end
