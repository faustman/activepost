# Redis Configuration
require 'redis'
require 'yaml'
require 'resque'
#redis_settings = YAML::load_file("config/redis.yml")
$redis = Redis.new # (redis_settings[ENV['RACK_ENV']])

Resque.redis = $redis

