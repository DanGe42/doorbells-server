# Load the redis config from the config/redis.yml file and expose redis as the
# global $redis
$redis = Redis.new(YAML.load_file("#{Rails.root}/config/redis.yml")[Rails.env])
