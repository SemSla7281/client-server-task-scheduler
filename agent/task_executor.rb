#
# Service which will execute the tasks
#
# @author [nityamvakil]
#
class TaskExecutor
  def initialize(params = {})
    @task_id = params[:id]
    @execution_path = params[:path]
    @arguments = params[:arguments]

    @command = 'sh ~/' + execution_path + ' ' + (arguments ? arguments : '')
  end

  attr_reader :task_id, :execution_path, :arguments, :command

  def execute
    LOGGER.info "Executing command - #{command}"
    system(command) ? success : failure
  rescue => e
    CustomTrace.log_trace e
  end

  private

  def success
    LOGGER.info 'Execution Succeded. Sending response to the server'
    Server.new.task_success(task_id)
  end

  def failure
    LOGGER.info 'Execution failed! Sending response to the server'
    Server.new.task_failure(task_id)
  end
end
