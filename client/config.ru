# This file is used by Rack-based servers to start the application.
$LOAD_PATH << ENV['LIB_HOME']
require ::File.expand_path('../config/environment', __FILE__)
run Rails.application
