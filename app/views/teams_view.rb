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
  end

  Create = New

  class Edit
    include Lotus::View
    layout :application
  end

  Update = Edit
end
