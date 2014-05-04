module Rooms
  class Index
    include Lotus::View
    layout :application
  end

  class Show
    include Lotus::View
    layout :application
  end

  class New
    include Lotus::View
    layout :application

    def form
      FormPresenter.new(locals[:form])
    end
  end

  Create = New

  class Edit
    include Lotus::View
    layout :application

    def form
      FormPresenter.new(locals[:form])
    end
  end

  Update = Edit
end
