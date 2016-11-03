module Tasks
  #
  # Trigger service for tasks
  # Sets redis events for every schedule of a task
  #
  # @author [nityamvakil]
  #
  class Trigger
    NAMESPACE = 'tasks'.freeze

    def initialize(task, expiries = [])
      @task = task
      @expiries = expiries
      @key_prefix = prefix
      @redis = ::RedisWrapper.new(NAMESPACE)
      clean
    end

    attr_reader :task, :expiries, :key_prefix, :redis

    def clean
      redis.clean key_prefix
    end

    def set
      expiries.each { |expiry| redis.set_with_expiry task_key(expiry), expiry }
    end

    private

    def prefix
      agent_key + '|' + NAMESPACE + '|' + attributes
    end

    def agent_key
      task.agent.encoded_key
    end

    def attributes
      ([element(:id)] + TASK_KEY_ATTRS.sort.map { |key| element key }).join('|')
    end

    def element(key)
      key.to_s + ':' + task.send(key).to_s
    end

    def task_key(expiry)
      key_prefix + '|' + expiry.to_s
    end
  end
end
