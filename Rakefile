require 'rubygems'
require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new(:spec) do |t|
  t.rspec_opts = %w( --color )
  t.rcov = true
  t.rcov_opts =  %w( --exclude spec,gems )
end
task :default => :spec