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
end
