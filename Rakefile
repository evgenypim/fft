# require "bundler/gem_tasks"

begin
  require 'bundler/setup'
rescue LoadError
  puts 'You must `gem install bundler` and `bundle install` to run rake tasks'
end

Bundler::GemHelper.install_tasks

require 'yard'
YARD::Rake::YardocTask.new(:doc) do |yard|
  yard.files = %w({app,models,lib}/**/*.rb)
  yard.options = %w(--embed-mixins --protected --plugin tomdoc)
end

require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new(:coverage) do |rspec|
  ENV['COVERAGE'] = 'true'
end