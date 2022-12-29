class Settings
  extend Dry::Configurable
  setting :name, default: 'Q&A', reader: true
  setting :human_strftime, default: '%d %B %Y %H:%m', reader: true
  setting :env, default: ENV.fetch('RACK_ENV', 'development'), reader: true
  setting :session_secret, default: ENV.fetch('SESSION_SECRENT', '1111poqweop12eko12peo12ml12123123213poqweop12eko12peo12ml12123123213poqweop12eko12peo12ml12123123213poqweop12eko12peo12ml12123123213'), reader: true
  setting :root, default: "#{__dir__}/..", constructor: -> (path) { Pathname(path).expand_path}, reader: true
end
