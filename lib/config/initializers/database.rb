require "active_record"

ActiveRecord::Base.establish_connection(
  adapter: 'postgresql',
  encoding: 'utf8',
  database: 'crawler_development',
  pool: 5,
  username: 'philipsmerud'
 )

