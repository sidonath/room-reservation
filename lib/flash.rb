require 'lotus/action/session'

# A basic Rails-like Flash implementation built upon Lotus::Action::Session.
# Based upon Rack-flash:
# https://github.com/nakajima/rack-flash
module Flash
  def self.included(action)
    action.class_eval do
      # We rely on features provided by Lotus::Action::Session so let's include
      # it right here
      include Lotus::Action::Session

      # Expose flash to the views
      expose :flash

      # Need to include this module to overwrite `flash` getter created by
      # `expose :flash` above
      prepend InstanceMethods
    end
  end

  class FlashHash
    attr_reader :flagged

    def initialize(store)
      @cache = {}
      @store = store
    end

    # Remove an entry from the session and return its value. Cache result in
    # the instance cache.
    def [](key)
      key = key.to_sym
      cache[key] ||= store.delete(key)
    end

    # Store the entry in the session, updating the instance cache as well.
    def []=(key,val)
      key = key.to_sym
      cache[key] = store[key] = val
    end

    # Store a flash entry for only the current request, swept regardless of
    # whether or not it was actually accessed. Useful for AJAX requests, where
    # you want a flash message, even though your response isn't redirecting.
    def now
      cache
    end

    # Checks for the presence of a flash entry without retrieving or removing
    # it from the cache or store.
    def has?(key)
      [cache, store].any? { |store| store.keys.include?(key.to_sym) }
    end
    alias_method :include?, :has?

    def keys
      cache.keys | store.keys
    end

    # Remove an entry from the session and pass its value to the given block.
    # Cache result in the instance cache.
    def given(key)
      return unless has? key
      return unless block_given?
      yield self[key]
    end

    private

    attr_reader :cache, :store
  end

  module InstanceMethods

    protected

    # Gets the flash hash from session (or creates one) and exposes it.
    def flash
      return @flash if @flash

      session['__flash__'] ||= {}
      @flash = FlashHash.new(session['__flash__'])
    end
  end
end
