require 'redis'

#
# Redis accessor module
#
# define accessors of all your reids namespaces
#
# @author [nityamvakil]
#
module RedisAccess
  class << self
    attr_accessor :tasks
  end
end

redis_connection = Redis.new(Rails.application.config_for(:redis))
RedisAccess.tasks = Redis::Namespace.new(:tasks, redis: redis_connection)
