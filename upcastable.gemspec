# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'upcastable/version'

Gem::Specification.new do |spec|
  spec.name          = 'upcastable'
  spec.version       = Upcastable::VERSION
  spec.authors       = ['abicky']
  spec.email         = ['takeshi.arabiki@gmail.com']

  spec.summary       = %q{Upcastable provides the feature to emulate upcasting in Ruby}
  spec.description   = <<-DESC
Duck typing sometimes results in `NoMethodError` unexpectedly by calling methods
some classes don't have even if the code pass a test using other classes which
have the methods. We can avoid such situations by upcasting.
All we have to do is implementing methods defined in the super class or module
and we don't have to care about whether or not methods defined only in some
subclasses are called.
  DESC
  spec.homepage      = 'https://github.com/abicky/upcastable'
  spec.license       = 'MIT'
  spec.required_ruby_version = '>= 1.9'

  all_files          = `git ls-files -z`.split("\x0")
  spec.files         = all_files.reject { |f| f.match(%r{^\.|(bin|spec)/}) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler',       '~> 1.11'
  spec.add_development_dependency 'rake',          '~> 10.0'
  spec.add_development_dependency 'rspec',         '~> 3.0'
  spec.add_development_dependency 'pry',           '~> 0.10'
  spec.add_development_dependency 'pry-doc',       '~> 0.8'
  spec.add_development_dependency 'benchmark-ips', '~> 2.3'
end
