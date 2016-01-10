module Animal
  def talk; end
end

class Cat
  include Animal

  def talk
    'Meow!'
  end

  def run
    'Running...'
  end
end

cat = Cat.new
cat.class           #=> Cat
cat.upcasted?       #=> false
cat.upcasting       #=> nil
cat.talk            #=> "Meow!"
cat.run             #=> "Running..."

animal = cat.upcast_to(Animal)
animal.class        #=> Cat
animal.upcasted?    #=> true
animal.upcasting    #=> Animal
animal.talk         #=> "Meow!"
animal.run          #=> NoMethodError: `run' is not defined in Animal
animal.downcast.run #=> "Running..."
