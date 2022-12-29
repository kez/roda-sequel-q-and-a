DB = Sequel.connect("sqlite://db/#{ENV.fetch('RACK_ENV', 'development')}.sqlite3")

Sequel::Model.plugin :timestamps, update_on_create: true
Sequel::Model.plugin :nanoid
Sequel::Model.plugin :validation_helpers
