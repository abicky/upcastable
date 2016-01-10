$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'upcastable'

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
