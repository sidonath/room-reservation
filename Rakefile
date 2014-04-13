require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new(:spec)
task default: :spec

task :server do
  exec 'bundle exec shotgun application.rb'
end
