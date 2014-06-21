# Require database loader
require_relative "database"

# Require db/models
Dir["#{ENV["PWD"]}/lib/db/models/*.rb"].each {|file| require_relative file }

