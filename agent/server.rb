require 'net/http'
require 'json'

#
# REST service talking to the host
#
# @author [nityamvakil]
#
class Server
  def initialize
    @base_url = CONSTANTS.fetch('api')
  end

  attr_reader :base_url, :uri

  def register(key)
    post '/agents', secret_key: key
  end

  def task_success(id)
    post '/task-success', id: id
  end

  def task_failure(id)
    post '/task-failure', id: id
  end

  private

  def post(url, params)
    make_uri url
    LOGGER.info "SERVER CALL - #{base_url + uri.path} with params: #{params}"
    log_response http.post(uri.path, encoded_params(params))
  end

  def make_uri(url)
    @uri = URI base_url + url
  end

  def encoded_params(params)
    URI.encode_www_form params if params
  end

  def http
    Net::HTTP.new(uri.host, uri.port)
  end

  def headers
    { key: CONSTANTS.fetch('agent_key') }
  end

  def log_response(raw_response)
    response = parse raw_response.body
    LOGGER.info "SERVER RESPONSE - #{response}"
    raise StandardError, 'Bad response from server' if raw_response.code.to_i != 200
    response['payload']
  end

  def parse(raw_json)
    JSON.parse(raw_json)
  end
end
