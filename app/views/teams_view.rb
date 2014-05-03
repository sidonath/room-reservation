module Teams
  class Index
    include Lotus::View
    layout :application
  end

  class New
    include Lotus::View
    layout :application
  end

  Create = New
end
