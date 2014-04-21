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
      @mappers = {}
      @adapters = {}
    end

    def setup_router(&block)
      @router = Lotus::Router.new(&block)
    end

    def setup_mapper(name, &block)
      mapper = Lotus::Model::Mapper.new(&block)
      mapper.load!
      @mappers[name.to_sym] = mapper
    end

    def setup_adapter(&block)
      initializer = AdapterInitializer.new(self, &block)
      @adapters[initializer.adapter_name] = initializer.adapter
    end

    def mapper(name)
      @mappers[name.to_sym]
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

  class AdapterInitializer
    attr_reader :adapter

    def initialize(application, &block)
      instance_eval(&block)

      mapper = application.mapper(@mapper)
      @adapter = @type.new(mapper, ENV.fetch(@database))

      # is there a better way to access it?
      @collections = mapper.instance_variable_get(:@collections)
      assign_attributes
      assign_adapter
    end

    def adapter_name
      @name
    end

    private

    def name(name)
      @name = name.to_sym
    end

    def type(type)
      @type = type
    end

    def mapper(mapper)
      @mapper = mapper.to_sym
    end

    def database(database)
      @database = database.to_s
    end

    def assign_attributes
      @collections.each do |name, collection|
        collection.entity.attributes = collection.attributes.keys - Array(collection.identity)
      end
    end

    def assign_adapter
      repositories = @collections.map { |name, collection|
        repository_name = "#{collection.entity.name}#{Lotus::Model::Mapping::Collection::REPOSITORY_SUFFIX}"
        Object.const_get(repository_name)
      }

      repositories.each do |repository|
        repository.adapter = @adapter
      end
    end
  end
end
