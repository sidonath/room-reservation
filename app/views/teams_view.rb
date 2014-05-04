module Teams
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

    def model
      FormPresenter.new(locals[:model])
    end
  end

  Create = New

  class Edit
    include Lotus::View
    layout :application

    def model
      FormPresenter.new(locals[:model])
    end
  end

  Update = Edit
end
