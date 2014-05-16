class Account
  class New
    include Lotus::View
    layout :application

    def model
      FormPresenter.new(locals[:model])
    end
  end

  Create = New

  class Membership
    include Lotus::View
    layout :application

    def team_form
      FormPresenter.new(locals[:team_form])
    end

    def membership_form
      FormPresenter.new(locals[:membership_form])
    end
  end

  Join = Membership
end
