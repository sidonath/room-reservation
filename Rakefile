require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new(:spec)
task default: :spec

task :server do
  exec 'bundle exec shotgun'
end

task :console do
  exec 'bundle exec pry -r./application.rb'
end

task :migrate do
  exec "sequel -m db/migrations `dotenv 'echo $DATABASE_URL'`"
end
