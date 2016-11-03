#
# API for agents
#
# TODO: Secure Authentiction
#
# @author [nityamvakil]
#
class AgentsController < ApplicationController
  def create
    @agent = Agent.create! agent_params.merge decode_key
    render json: { payload: @agent.encoded_key }
  end

  private

  def agent_params
    params.permit(*permitted_columns.flatten)
  end

  def permitted_columns
    Agent.column_names - %w(id created_at updated_at)
  end

  def decode_key
    { decode_key: agent_params[:secret_key] }
  end
end
