class Object

  # Upcasts the object to the specified class or module.
  # Internally, the upcasted object is a Upcastable::UpcastedObject instance which
  # delegates almost all methods to the original object.
  #
  # @param [Class, Module] ancestor the ancestor to which the object is upcasted
  # @return the upcasted object
  # @raise [ArgumentError] if +ancestor+ is not an ancestor
  #
  # @example
  #
  #   module Animal
  #     def talk; end
  #   end
  #
  #   class Cat
  #     include Animal
  #
  #     def talk
  #       'Meow!'
  #     end
  #
  #     def run
  #       'Running...'
  #     end
  #   end
  #
  #   animal = Cat.new.upcast_to(Animal)
  #   animal.class #=> Cat
  #   animal.talk  #=> "Meow!"
  #   animal.run   #=> NoMethodError: `run' is not defined in Animal
  #
  def upcast_to(ancestor)
    ::Upcastable::UpcastedObject.new(self, ancestor)
  end

  # @return [Class, Module, nil] the ancestor to which the object have been upcasted
  def upcasting
    nil
  end

  # Returns true if the object is upcasted
  #
  # @return [true, false]
  def upcasted?
    false
  end

  # Downcasts the object to the original class
  #
  # @return the downcasted object (the original object)
  def downcast
    self
  end
end
