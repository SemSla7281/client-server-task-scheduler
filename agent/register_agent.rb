#
# Agent Registration
#
# TODO: Secure Authentication using key sharing
#
# @author [nityamvakil]
#
class RegisterAgent
  def initialize
    CONSTANTS['agent_key'] = read_from_file || register
  end

  def read_from_file
    LOGGER.info 'READING FILE FOR AGENT_KEY'
    key = File.open('agent/key', 'r').gets
    key ? key.strip : false
  rescue Errno::ENOENT
    false
  end

  def register
    LOGGER.info 'REGISTERING AGENT'
    write Server.new.register(generate_key)
  rescue StandardError => e
    CustomTrace.log_trace e
  end

  def write(key)
    LOGGER.info 'KEY WRITTEN'
    File.open('agent/key', 'w') { |f| f.puts key }
    key
  end

  def generate_key
    (0...8).map { (65 + rand(26)).chr }.join
  end
end
