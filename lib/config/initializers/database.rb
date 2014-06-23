require "active_record"

ActiveRecord::Base.establish_connection(
  adapter: 'postgresql',
  encoding: 'utf8',
  database: 'leaselabs_development',
  pool: 5,
  username: 'developer'
 )

