module Rooms
  class Index
    include Lotus::View
    layout :application
    attr_accessor :router

    def initialize(template, locals, router: Application.router)
      super(template, locals)
      @router = router
    end
  end

  class New
    include Lotus::View
    layout :application
    attr_accessor :router

    def initialize(template, locals, router: Application.router)
      super(template, locals)
      @router = router
    end
  end

  Create = New
end
