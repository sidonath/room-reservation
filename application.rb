require 'lotus/router'
require 'lotus/controller'
require 'lotus/view'
require 'pathname'
require 'dotenv'
require 'sequel'
require_relative 'lotus'

ApplicationRoot = Pathname.new(__FILE__).dirname
Dir.glob(ApplicationRoot.join('app/*/*.rb')) { |file| require file }

Dotenv.load
DB = Sequel.connect(ENV.fetch('DATABASE_URL'))

Lotus::View.root = ApplicationRoot.join('app/templates')
Lotus::View.load!

router = Lotus::Router.new do
  get '/', to: 'home#index'
end

Application = Rack::Builder.new do
  use Rack::Static, :urls => ["/stylesheets"], :root => "public"

  run Lotus::Application.new(router)
end.to_app
