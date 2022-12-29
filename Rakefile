require 'bundler'
require 'logger'
Bundler.require
require_relative 'config/sequel'

migrate = lambda do |env, version|
  ENV['RACK_ENV'] = env
  Sequel.extension :migration
  DB.loggers << Logger.new($stdout) if DB.loggers.empty?
  Sequel::Migrator.apply(DB, 'migrate', version)
end

desc 'Migrate test database to latest version'
task :test_up do
  migrate.call('test', nil)
end

desc 'Migrate test database all the way down'
task :test_down do
  migrate.call('test', 0)
end

desc 'Migrate test database all the way down and then back up'
task :test_bounce do
  migrate.call('test', 0)
  Sequel::Migrator.apply(DB, 'migrate')
end

desc 'Migrate development database to latest version'
task :dev_up do
  migrate.call('development', nil)
end

desc 'Migrate development database to all the way down'
task :dev_down do
  migrate.call('development', 0)
end

desc 'Migrate development database all the way down and then back up'
task :dev_bounce do
  migrate.call('development', 0)
  Sequel::Migrator.apply(DB, 'migrate')
end

desc 'Migrate production database to latest version'
task :prod_up do
  migrate.call('production', nil)
end

desc 'Seed dummy data'
task :seed do
  Dir['./models/**/*.rb'].each { |model| require model }
  require 'faker'
  (1..3).to_a.each do |user_prefix|
    handle = "user#{user_prefix}"
    email = "#{handle}@localhost.dev"
    user = User.find_or_create(email:, handle:)

    question_title = "Can #{%w[someone you anyone].sample} help me with #{Faker::ProgrammingLanguage.name}?"
    Question.find_or_create(user:, title: question_title, body: "I can't work it out myself")
  end
end
