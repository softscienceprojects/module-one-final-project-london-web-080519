require 'bundler/setup'
Bundler.require

require 'active_record'
require 'rake'

require_all 'app'

ActiveRecord::Base.establish_connection(
    adapter: 'sqlite3', 
    database: './db/development.db')
require_all 'lib'