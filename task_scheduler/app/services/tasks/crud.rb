module Tasks
  #
  # CRUD service for tasks
  #
  # @author [nityamvakil]
  #
  class Crud
    def initialize(params = {})
      @params = params
    end

    attr_reader :params

    def create
      schedule task = Task.create!(params)
      task
    end

    def update
      task = Task.find(params[:id])
      task.update! params.merge status_on_update
      schedule task
      task
    end

    def destroy
      clean_schedules Task.destroy params[:id]
    end

    private

    def schedule(task)
      Scheduler.new(task).schedule
    end

    def clean_schedules(task)
      Trigger.new task
    end

    def status_on_update
      { status: 'scheduled' }
    end
  end
end
