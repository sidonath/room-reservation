class HomeController
  include Lotus::Controller

  action 'Index' do
    expose :planet

    def call(params)
      @planet = 'World'
    end
  end
end
