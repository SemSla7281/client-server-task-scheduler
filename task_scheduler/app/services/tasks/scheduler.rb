module Tasks
  #
  # Scheduler service for computing weekly schedules
  #
  # @author [nityamvakil]
  #
  class Scheduler
    SECONDS_IN_A_DAY = 24 * 60 * 60

    def initialize(task)
      @task = task
      @start_time = task.start_time
      @end_time = task.end_time
    end

    attr_reader :task, :schedules, :start_time, :end_time

    #
    # Schedules dates on which task will be executed
    # - calculates expiry in seconds for every valid schedule date
    # - sets redis keys with the expiries
    #
    # @return [Array] [valid expiries from the set time]
    def schedule
      add_triggers_for expiries
    end

    private

    def add_triggers_for(expiry_list)
      Trigger.new(task, expiry_list).set
    end

    def expiries
      schedues.map { |timestamp| expiry_in_seconds timestamp }.compact
    end

    def expiry_in_seconds(timestamp)
      expiry = timestamp.to_i - Time.zone.now.to_i
      expiry > 0 ? expiry : nil
    end

    def schedues
      dates.select { |date| includes_weekday?(date) }
    end

    def dates
      Array.new(days_diff + 1) { |i| start_time + i.day }
    end

    def days_diff
      (end_time - start_time).to_i / SECONDS_IN_A_DAY
    end

    def includes_weekday?(date)
      task.weekdays.include? weekday(date)
    end

    def weekday(time)
      time.strftime('%A').downcase
    end
  end
end
