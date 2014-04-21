require_relative 'lotus'
require 'pathname'
require 'dotenv'
require 'reform'

Dotenv.load

Lotus::Controller.handle_exceptions = false

ApplicationRoot = Pathname.new(__FILE__).dirname
Dir.glob(ApplicationRoot.join('app/*/*.rb')) { |file| require file }

Lotus::View.root = ApplicationRoot.join('app/templates')
Lotus::View.load!

Application = Lotus::Application.new

require_relative 'config/routes'
Dir.glob(ApplicationRoot.join('config/mappers/*.rb')) { |file| require file }
Dir.glob(ApplicationRoot.join('config/adapters/*.rb')) { |file| require file }
