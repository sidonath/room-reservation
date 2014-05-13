class TeamsController
  class Index
    include RoomReservation::Action

    def initialize(repository: TeamRepository)
      @repository = repository
    end

    def call(params)
      @model = @repository.sorted_by_name
    end
  end

  class Show
    include RoomReservation::Action

    def initialize(repository: TeamRepository)
      @repository = repository
    end

    def call(params)
      @model = @repository.find(params[:id])
    end
  end

  class New
    include RoomReservation::Action

    def call(params)
      @model = TeamsFormFactory.create
    end
  end

  class Create
    include RoomReservation::Action

    def initialize(repository: TeamRepository)
      @repository = repository
    end

    def call(params)
      @model = TeamsFormFactory.create
      team = @model.populate(params.fetch(:team), self)
      @repository.persist(team)

      if current_user.id
        current_user.team_id = team.id
        UserRepository.persist(current_user)
        flash[:notice] = "You are now part of team #{team.name}!"
      else
        flash[:notice] = 'The team was created!'
      end

      redirect_to @router.path(:teams)
    end

    def form_invalid
      throw 422
    end
  end

  class Edit
    include RoomReservation::Action

    def initialize(repository: TeamRepository)
      @repository = repository
    end

    def call(params)
      @model = TeamsFormFactory.update(@repository.find(params[:id]))
    end
  end

  class Update
    include RoomReservation::Action

    def initialize(repository: TeamRepository)
      @repository = repository
    end

    def call(params)
      @model = TeamsFormFactory.update(@repository.find(params[:id]))
      team = @model.populate(params.fetch(:team), self)
      @repository.persist(team)

      flash[:notice] = 'The team was updated!'
      redirect_to @router.path(:teams)
    end

    def form_invalid
      throw 422
    end
  end

  class Destroy
    include RoomReservation::Action

    def initialize(repository: TeamRepository)
      @repository = repository
    end

    def call(params)
      @model = @repository.find(params[:id])
      @repository.delete(@model)

      flash[:notice] = 'The team was deleted!'
      redirect_to @router.path(:teams)
    end
  end
end
