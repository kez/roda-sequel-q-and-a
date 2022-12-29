require 'bundler'
require 'logger'
require 'pry'
Bundler.require
  
require 'rack/unreloader'
logger = Logger.new($stdout)
Unreloader = Rack::Unreloader.new(subclasses: %w'Roda Sequel::Model Actor', logger: logger, reload: ENV['RACK_ENV'] == 'development'){App}
Unreloader.require('app.rb'){'App'}

if ENV['RACK_ENV'] == 'production'
  run App.freeze.app
else
 run Unreloader
end