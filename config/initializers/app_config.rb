# Load configuration from the config/config.yml file and expose as APP_CONFIG
APP_CONFIG = YAML.load_file("#{Rails.root}/config/config.yml")[Rails.env]
