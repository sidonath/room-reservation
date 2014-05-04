class Account
  class New
    include Lotus::View
    layout :application

    def model
      FormPresenter.new(locals[:model])
    end
  end

  Create = New
end
