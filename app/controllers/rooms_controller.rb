class RoomsController
  include Lotus::Controller

  action 'Index' do
    expose :rooms

    def initialize(repository: RoomRepository)
      @repository = repository
    end

    def call(params)
      @rooms = @repository.sorted_by_name
    end
  end

  action 'New' do
    expose :form

    def call(params)
      @form = FormFactory.new_room
    end
  end

  action 'Create' do
    expose :form

    def initialize(repository: RoomRepository, router: Application.router)
      @repository = repository
      @router = router
    end

    def call(params)
      @form = FormFactory.new_room
      room  = @form.populate(params.fetch(:room), self)
      @repository.persist(room)
      redirect_to @router.path(:rooms)
    end

    def form_invalid
      throw 422
    end
  end

  action 'Edit' do
    expose :form

    def initialize(repository: RoomRepository, router: Application.router)
      @repository = repository
      @router = router
    end

    def call(params)
      @form = FormFactory.edit_room(@repository.find(params.fetch(:id)))
    end
  end

  action 'Update' do
    expose :form

    def initialize(repository: RoomRepository, router: Application.router)
      @repository = repository
      @router = router
    end

    def call(params)
      @form = FormFactory.edit_room(@repository.find(params.fetch(:id)))
      room  = @form.populate(params.fetch(:room), self)
      @repository.persist(room)
      redirect_to @router.path(:rooms)
    end

    def form_invalid
      throw 422
    end
  end

  action 'Destroy' do
    def initialize(repository: RoomRepository, router: Application.router)
      @repository = repository
      @router = router
    end

    def call(params)
      room = @repository.find(params.fetch(:id))
      @repository.delete(room)
      redirect_to @router.path(:rooms)
    end
  end
end
