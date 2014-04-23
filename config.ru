require File.expand_path("../application", __FILE__)

use Rack::Static, :urls => ['/stylesheets', '/javascripts'], :root => "public"
use Rack::MethodOverride
run Application
