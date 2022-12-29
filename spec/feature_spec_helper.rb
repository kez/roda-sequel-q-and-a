require 'rack/unreloader'
require 'capybara/rspec'
require 'capybara/dsl'
require 'rack/test'

Unreloader = Rack::Unreloader.new(subclasses: %w'Roda Sequel::Model Actor'){App}
Unreloader.require('app.rb'){'App'}

require_relative '../app'

Capybara.app = App.freeze.app
Capybara.exact = true