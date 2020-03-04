require "redis"

class CacheHelper
  def self.get(key)
    redis = connect()
    redis.get(key)
  end

  def self.save(key, value)
    redis = connect()
    redis.set(key, value, ex: 30)
  end

private
  def self.connect
    Redis.new(host: ENV["REDIS_HOST"], port: ENV["REDIS_PORT"])
  end
end
