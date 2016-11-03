require 'redis'
require 'redis-namespace'

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

LOGGER.info '##### Initiating redis connection #####'

begin
  redis_connection = Redis.new(CONSTANTS.fetch('redis'))
  RedisAccess.tasks = Redis::Namespace.new(:tasks, redis: redis_connection)
rescue => e
  CustomTrace.log_trace e
end
