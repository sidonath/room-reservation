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
    def initialize(router, renderer = RenderingPolicy.new)
      @router   = router
      @renderer = renderer
    end

    def call(env)
      _call(env).tap do |response|
        response[2] = Array(@renderer.render(response))
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
        view.render(action.to_rendering)
      end
    end

    private
    def render?(response)
      response.last.respond_to?(:to_rendering)
    end

    def view_for(action)
      Object.const_get(action.class.name.gsub(/Controller/, ''))
    end
  end
end