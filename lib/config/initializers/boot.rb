# Require database loader
require_relative "database"

# Require db/models
Dir["../../db/models/*.rb"].each {|file| require file }

