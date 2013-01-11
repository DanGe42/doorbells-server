# Load configuration from the config/config.yml file and expose as APP_CONFIG
path = "#{Rails.root}/config/config.yml"
APP_CONFIG = YAML.load(ERB.new(File.new(path).read).result)[Rails.env]
