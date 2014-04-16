class RoomsController
  include Lotus::Controller

  action 'Index' do
    expose :rooms

    def initialize(repository: Room)
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
    def initialize(repository: Room)
      @repository = repository
    end

    def call(params)
      room = @repository.new(params[:room])
      room.save
      return redirect_to Router.path(:rooms)
    end
  end
end
