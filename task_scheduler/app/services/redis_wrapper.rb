#
# Redis accessor
#
# @author [nityamvakil]
#
class RedisWrapper
  def initialize(namespace)
    @redis = RedisAccess.send(namespace)
  end

  attr_reader :redis

  def clean(prefix)
    matching_keys(prefix).each { |key| redis.del key }
  end

  def set_with_expiry(key, expiry)
    redis.set key, true
    redis.expire key, expiry
  end

  private

  def matching_keys(prefix)
    redis.keys.select { |key| key.match regexp prefix }
  end

  def regexp(prefix)
    /^#{prefix.gsub('|', '\|')}*/
  end
end
