class AccountController
  class New
    include RoomReservation::Action

    def call(params)
      @model = UserFormFactory.create
    end
  end

  class Create
    include RoomReservation::Action

    def initialize(repository: UserRepository)
      @repository = repository
    end

    def call(params)
      @model = UserFormFactory.create
      user = @model.populate(params.fetch(:user), self)
      @repository.persist(user)
      sign_in!(user)

      flash[:notice] = 'Your account has been created!'
      redirect_to @router.path(:membership_account)
    end

    def form_invalid
      throw 422
    end

    def sign_in!(user)
      session[:user_id] = user.id
    end
  end

  class Membership
    include RoomReservation::Action
    expose :team_form, :membership_form, :teams
    exposures.delete :model

    def initialize(repository: TeamRepository)
      @repository = repository
    end

    def call(params)
      @team_form       = TeamsFormFactory.create
      @membership_form = MembershipFormFactory.create(current_user)
      @teams           = @repository.sorted_by_name
    end
  end

  class Join
    include RoomReservation::Action
    expose :team_form, :membership_form, :teams

    # a problem: since model is automatically exposed by
    # RoomReservation::Action, any partial that accesses model, will ignore
    # `locals: { model: something_else }` so we had to remove it here. The
    # better solution is to fix partial rendering :)
    exposures.delete :model

    def initialize(repository: TeamRepository)
      @repository = repository
    end

    def call(params)
      @membership_form = MembershipFormFactory.create(current_user)
      user = @membership_form.populate(params.fetch(:user), self)

      # TODO: this is partially a business logic (assigning a user to the team)
      # and partially storage logic (assigning team.id to users.team_id) and
      # persisting it. What's the best place to do it?
      current_user.team_id = user.team_id
      team = @repository.find(current_user.team_id)
      UserRepository.persist(current_user)

      flash[:notice] = "You are now part of team #{team.name}!"
      redirect_to router.path(:root)
    end
  end
end
