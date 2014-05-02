require File.expand_path("../application", __FILE__)

use Rack::Session::Cookie, secret: ENV.fetch('RACK_SECRET')
use Rack::Static, :urls => ['/stylesheets', '/javascripts'], :root => "public"
use Rack::MethodOverride
run Application
