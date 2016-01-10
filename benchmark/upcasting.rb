require 'upcastable'
require 'benchmark/ips'

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

cat    = Cat.new
animal = cat.upcast_to(Animal)

puts 'Object instance methods (#object_id)'
Benchmark.ips do |x|
  x.report('baseline') { cat.object_id }
  x.report('upcasting') { animal.object_id }
  x.compare!
end

puts 'Animal instance methods (#talk)'
Benchmark.ips do |x|
  x.report('baseline') { cat.talk }
  x.report('upcasting') { animal.talk }
  x.compare!
end
