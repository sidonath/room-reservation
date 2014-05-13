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
      redirect_to @router.path(:new_teams)
    end

    def form_invalid
      throw 422
    end

    def sign_in!(user)
      session[:user_id] = user.id
    end
  end
end
