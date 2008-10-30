require 'rubygems'
require 'test/spec'
require 'mocha'
require 'action_controller'
require 'active_record'
require 'sqlite3'

require File.expand_path(File.dirname(__FILE__) + '/../lib/finder_filter')

# connect to the database (sqlite in this case)
ActiveRecord::Base.establish_connection({
      :adapter => 'sqlite3', 
      :dbfile => File.expand_path(File.dirname(__FILE__) + '/../db/test.sqlite')
})
