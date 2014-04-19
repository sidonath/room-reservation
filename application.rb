require 'lotus/router'
require 'lotus/controller'
require 'lotus/view'
require 'lotus/model'
require 'lotus/model/adapters/sql_adapter'
require 'pathname'
require 'dotenv'
require 'sequel'
require 'reform'
require_relative 'lotus'

Dotenv.load

Lotus::Controller.handle_exceptions = false

ApplicationRoot = Pathname.new(__FILE__).dirname
Dir.glob(ApplicationRoot.join('app/*/*.rb')) { |file| require file }

Lotus::View.root = ApplicationRoot.join('app/templates')
Lotus::View.load!

mapper = Lotus::Model::Mapper.new do
  collection :rooms do
    entity Room

    attribute :id,          Integer
    attribute :name,        String
    attribute :description, String
  end
end

mapper.load!

adapter = Lotus::Model::Adapters::SqlAdapter.new(mapper, ENV.fetch('DATABASE_URL'))

RoomRepository.adapter = adapter

Router = router = Lotus::Router.new do
  get '/', to: 'home#index'

  resources :rooms
end

Application = Rack::Builder.new do
  use Rack::Static, :urls => ["/stylesheets"], :root => "public"

  run Lotus::Application.new(router)
end.to_app
