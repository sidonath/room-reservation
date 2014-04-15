require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new(:spec)
task default: :spec

task :server do
  exec 'bundle exec shotgun application.rb'
end

task :console do
  exec 'bundle exec pry -r./application.rb'
end
