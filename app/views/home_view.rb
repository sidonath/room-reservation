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
