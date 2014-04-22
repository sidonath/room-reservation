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

    def initialize(entity_class: Room, form_class: RoomForm)
      @entity_class = Room
      @form_class = RoomForm
    end

    def call(params)
      @form = @form_class.new(@entity_class.new)
    end
  end

  action 'Create' do
    expose :form

    def initialize(repository: RoomRepository, entity_class: Room, form_class: RoomForm, router: Application.router)
      @repository = repository
      @form_class = form_class
      @entity_class = entity_class
      @router = router
    end

    def call(params)
      @room = @entity_class.new
      @form = @form_class.new(@room)

      unless @form.validate(params.fetch(:room).stringify_keys)
        self.status = 422
        return
      end

      @form.save
      @repository.persist(@room)
      return redirect_to @router.path(:rooms)
    end
  end
end
