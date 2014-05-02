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
  require 'dotenv'
  Dotenv.load

  exec "sequel -m db/migrations #{ENV.fetch('DATABASE_URL')}"
end
