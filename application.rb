require 'lotus/router'
require 'lotus/controller'
require 'lotus/view'
require_relative 'lotus'

class HomeController
  include Lotus::Controller

  action 'Index' do
    expose :planet

    def call(params)
      @planet = 'World'
    end
  end
end

class ApplicationLayout
  include Lotus::Layout
end

module Home
  class Index
    include Lotus::View

    layout :application

    def salutation
      'Hello'
    end

    def greet
      "#{ salutation }, #{ planet }!"
    end
  end
end

Lotus::View.root = __dir__ + '/templates'
Lotus::View.load!

router = Lotus::Router.new do
  get '/', to: 'home#index'
end

Application = Rack::Builder.new do
  use Rack::Static, :urls => ["/stylesheets"], :root => "public"

  run Lotus::Application.new(router)
end.to_app
