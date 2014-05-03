class TeamsController
  class Index
    include RoomReservation::Action

    def initialize(repository: TeamRepository, router: Application.router)
      @repository = repository
      @router = router
    end

    def call(params)
      @model = @repository.sorted_by_name
    end
  end

  class New
    include RoomReservation::Action

    def initialize(router: Application.router)
      @router = router
    end

    def call(params)
      @model = TeamsFormFactory.create
    end
  end

  class Create
    include RoomReservation::Action

    def initialize(repository: TeamRepository, router: Application.router)
      @repository = repository
      @router = router
    end

    def call(params)
      @model = TeamsFormFactory.create
      team = @model.populate(params.fetch(:team), self)
      @repository.persist(team)

      flash[:notice] = 'The team was created!'
      redirect_to @router.path(:teams)
    end

    def form_invalid
      throw 422
    end
  end
end
