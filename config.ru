# This file is used by Rack-based servers to start the application.

require ::File.expand_path('../config/environment',  __FILE__)
run Rails.application


# Modifico il path

#map Rails::Application.config.relative_url_root || "/asuca" do
#    run Rails.Application
# end
