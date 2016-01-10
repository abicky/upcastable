# Upcastable [![Build Status](https://travis-ci.org/abicky/upcastable.svg?branch=master)](https://travis-ci.org/abicky/upcastable)

Upcastable provides the feature to emulate upcasting in Ruby.

Duck typing sometimes results in `NoMethodError` unexpectedly by calling methods some classes don't have even if the code pass a test using other classes which have the methods. We can avoid such situations by upcasting. All we have to do is implementing methods defined in the super class or module and we don't have to care about whether or not methods defined only in some subclasses are called.


## Installation

Add this line to your application's Gemfile:

```ruby
gem 'upcastable'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install upcastable

## Usage

We define `Animal` module and `Cat` class to explain the usage like below:

```ruby
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
```

Upcastable defines `Object#upcast_to` and you can use `Animal` like a interface by upcasting `Cat` object to `Animal`.

```ruby
cat = Cat.new
animal = cat.upcast_to(Animal)
animal.class #=> Cat
animal.talk  #=> "Meow!"
animal.run   #=> NoMethodError: `run' is not defined in Animal
```

Internally, the upcasted object is a `Upcastable::UpcastedObject` instance which delegates almost all methods to the original object. Therefore the value of `#object_id` is not changed.

```ruby
cat.object_id == animal.object_id #=> true
```


You can also downcast the upcasted object to the original class by calling `Object#downcast`.

```ruby
animal.downcast.run #=> "Running..."
```

There are two additional methods,  `Object#upcasting` and `Object#upcasted?`. `Object#upcasting` returns the ancestor to which the object have been upcasted and `Object#upcasted?` returns `true` if the object is upcasted.

```ruby
cat.upcasted?    #=> false
cat.upcasting    #=> nil
animal.upcasted? #=> true
animal.upcasting #=> Animal
```


## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/abicky/upcastable. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
