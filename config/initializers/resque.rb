rails_root = Rails.root || File.dirname(__FILE__) + '/../..'
rails_env  = Rails.env || 'development'

resque_config = YAML.load(ERB.new(File.new("#{rails_root}/config/resque.yml").read).result)[rails_env]

host = resque_config["host"]
port = resque_config["port"]
db   = resque_config["db"]
Resque.redis = "#{host}:#{port}:#{db}"
