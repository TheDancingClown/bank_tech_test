# frozen_string_literal: true

require 'rake'
require 'rspec/core/rake_task'
require 'simplecov'
SimpleCov.start
RSpec::Core::RakeTask.new(:spec) do |t|
  t.pattern = Dir.glob('spec/**/*_spec.rb')
  t.rspec_opts = '--format documentation'
end
task default: :spec
