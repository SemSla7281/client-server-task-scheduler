require 'logger'
require 'byebug'
require 'yaml'

$LOAD_PATH << '.'

LOGGER = Logger.new('agent/log/agent.log')
LOGGER.info '##### Initiating agent client #####'

require 'agent/custom_trace'

begin
  env = ARGV.first || 'development'
  key = ARGV[1]
  File.open('agent/key', 'w') { |f| f.puts key } if key

  CONSTANTS = YAML.load_file('agent/config.yml').fetch(env, nil)
  raise StandardError, 'Invalid Environment!' if CONSTANTS.nil?
rescue => e
  CustomTrace.log_trace e
end

require 'agent/redis_access'
require 'agent/task_executor'
require 'agent/server'
require 'agent/register_agent'

RegisterAgent.new
require 'agent/listener'
