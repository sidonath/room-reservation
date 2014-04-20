require File.expand_path("../application", __FILE__)

use Rack::Static, :urls => ["/stylesheets"], :root => "public"
run Application
