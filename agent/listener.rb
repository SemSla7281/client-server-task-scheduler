require 'fileutils'
LOGGER.info '##### Initiating Listener #####'

def active_task?(params)
  params[:is_active]
end

begin
  initiate_listener = system('redis-cli config set notify-keyspace-events KEA')
  raise 'Redis Listener could not be initiated' unless initiate_listener

  events = ['__keyevent@0__:expired']

  RedisAccess.tasks.redis.psubscribe(*events) do |on|
    on.pmessage do |_channel, _event, key|
      LOGGER.info 'Received event with key: ' + key

      #
      # Sample key:
      #
      # NAMESPACE:AGENT_KEY|NAMESPACE|id:123|path:'~/sometask/task'|arguments:'arg1 arg2'|is_active:false
      #
      event_arguments = key.split('|')
      agent_key = event_arguments.first.split(':').last

      if CONSTANTS['agent_key'] == agent_key
        length = event_arguments.length - 1

        params = event_arguments[2..length].inject({}) do |hash, pair|
          key, value = pair.split(':')
          hash.merge(key.to_sym => value)
        end

        TaskExecutor.new(params).execute if active_task?(params)
      else
        LOGGER.info 'Invalid agent key! - ' + agent_key
      end
    end
  end
rescue => e
  FileUtils.rm('agent/key')
  CustomTrace.log_trace e
end
