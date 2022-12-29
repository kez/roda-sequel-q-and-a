ENV['RACK_ENV'] = 'test'

require 'bundler'
Bundler.require

require 'faker'
require 'pry'
require 'factory_bot'

require_relative '../config/sequel'

Dir['./services/**/*.rb'].each { |service| require service }
Dir['./models/**/*.rb'].each { |model| require model }
Dir['./spec/factories/*.rb'].each { |factory| require factory }

FactoryBot.define do
  to_create(&:save)
end

RSpec.configure do |c|
  c.include FactoryBot::Syntax::Methods
  c.around(:each) do |example|
    DB.transaction(rollback: :always, auto_savepoint: true) { example.run }
  end
end
