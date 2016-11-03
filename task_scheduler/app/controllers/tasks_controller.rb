#
# API for tasks
#
# @author [nityamvakil]
#
class TasksController < ApplicationController
  before_action :agents, only: [:index]

  def index
    @tasks = Task.all
    render json: { payload: @tasks, meta: { count: @tasks.count,
                                            weekdays: WEEKDAYS,
                                            agents: @agents } }
  end

  def show
    @task = Task.find params[:id]
    render json: { payload: @task, meta: { weekdays: WEEKDAYS } }
  end

  def create
    @task = Tasks::Crud.new(task_params).create
    render json: { payload: @task, meta: { id: @task.id } }
  end

  def update
    @task = Tasks::Crud.new(task_params).update
    render json: { payload: @task, meta: { id: @task.id } }
  end

  def destroy
    @task = Tasks::Crud.new(task_params).destroy
    render json: { meta: { id: params[:id] } }
  end

  def success
    Task.find(params[:id]).update! status: 'executed'
    render json: { meta: { message: 'Updated task with success!' } }
  end

  def failure
    Task.find(params[:id]).update! status: 'failed'
    render json: { meta: { message: 'Updated task with failure!' } }
  end

  private

  def task_params
    params.permit(*permitted_columns.flatten)
  end

  def permitted_columns
    Task.column_names - %w(created_at updated_at weekdays status) + [{ weekdays: [] }]
  end

  def agents
    @agents = Agent.pluck(:id)
  end
end
