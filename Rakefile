require 'bundler/gem_tasks'
require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new(:spec)

task :default => :spec

task :benchmark do
  ruby 'benchmark/upcasting.rb'
end
