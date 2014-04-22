class RoomsController
  include Lotus::Controller

  action 'Index' do
    expose :rooms

    def initialize(repository: RoomRepository)
      @repository = repository
    end

    def call(params)
      @rooms = @repository.all
    end
  end

  action 'New' do
    expose :form

    def call(params)
      @form = FormProvider.new_room
    end
  end

  action 'Create' do
    expose :form

    def initialize(repository: RoomRepository, router: Application.router)
      @repository = repository
      @router = router
    end

    def call(params)
      @form = FormProvider.new_room

      unless @form.validate(params.fetch(:room).stringify_keys)
        self.status = 422
        return
      end

      @form.save
      @repository.persist(@form.model)
      return redirect_to @router.path(:rooms)
    end
  end
end
