require 'lotus/router'
require 'lotus/controller'
require 'lotus/view'
require 'pathname'
require 'dotenv'
require 'sequel'
require 'reform'
require_relative 'lotus'

Dotenv.load
DB = Sequel.connect(ENV.fetch('DATABASE_URL'))

Lotus::Controller.handle_exceptions = false

ApplicationRoot = Pathname.new(__FILE__).dirname
Dir.glob(ApplicationRoot.join('app/*/*.rb')) { |file| require file }

Lotus::View.root = ApplicationRoot.join('app/templates')
Lotus::View.load!

Router = router = Lotus::Router.new do
  get '/', to: 'home#index'

  resources :rooms
end

Application = Rack::Builder.new do
  use Rack::Static, :urls => ["/stylesheets"], :root => "public"

  run Lotus::Application.new(router)
end.to_app
