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
    def call(params)
    end
  end

  action 'Create' do
    def initialize(repository: RoomRepository, entity_class: Room, form_class: RoomForm)
      @repository = repository
      @form_class = form_class
      @entity_class = entity_class
    end

    def call(params)
      @room = @entity_class.new
      @form = @form_class.new(@room)

      unless @form.validate(params.fetch(:room).stringify_keys)
        return redirect_to Router.path(:rooms, :new)
      end

      @form.save
      @repository.persist(@room)
      return redirect_to Router.path(:rooms)
    end
  end
end
