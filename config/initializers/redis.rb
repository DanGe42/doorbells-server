# Load the redis config from the config/redis.yml file and expose redis as the
# global $redis
path = "#{Rails.root}/config/redis.yml"
$redis = Redis.new(YAML.load(ERB.new(File.new(path).read).result)[Rails.env])
