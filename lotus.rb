module FullStackPatch
  def response
    [ super, self ].flatten
  end

  def format
    Rack::Mime::MIME_TYPES.invert[content_type].gsub(/\A\./, '').to_sym
  end

  def to_rendering
    exposures.merge(format: format)
  end
end

Lotus::Action::Rack.class_eval do
  prepend FullStackPatch
end

module Lotus
  class Application
    attr_accessor :router

    def initialize(renderer = RenderingPolicy.new)
      @renderer = renderer
    end

    def setup_router(&block)
      @router = Lotus::Router.new(&block)
    end

    def build_rack_app(&block)
      Rack::Builder.new(&block).to_app
    end

    def call(env)
      _call(env).tap do |response|
        @renderer.render(response)
      end
    end

    private
    def _call(env)
      env['HTTP_ACCEPT'] ||= 'text/html'
      @router.call(env)
    end
  end

  class RenderingPolicy
    def render(response)
      if render?(response)
        action = response.pop
        view   = view_for(action)
        response[2] = Array(view.render(action.to_rendering))
      end
    end

    private
    def render?(response)
      return false unless (200..299).include?(response.first)
      response.last.respond_to?(:to_rendering)
    end

    def view_for(action)
      Object.const_get(action.class.name.gsub(/Controller/, ''))
    end
  end
end
