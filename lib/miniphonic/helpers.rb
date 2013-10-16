require 'mime/types'

module Miniphonic::Helpers

  # Posts data to the server and executes a given block on success
  def to_server(url, payload = {}, &block)
    connection = Miniphonic.connect
    raw_response = connection.post url, payload
    handle_response(raw_response, &block)
  end

  # Gets data from the server and executes a given block on success
  def from_server(url, payload = {}, &block)
    connection = Miniphonic.connect
    raw_response = connection.get url, payload
    handle_response(raw_response, &block)
  end

  # Deletes data from the server and executes a given block on success
  def delete_from_server(url, payload = {}, &block)
    connection = Miniphonic.connect
    response = connection.delete url, payload
    if response.success?
      block.call(response) if block
      response
    else
      raise server_error(response)
    end
  end

  def handle_response(raw_response, &block)
    response = Miniphonic::Response.new(raw_response)

    if response.success?
      block.call(response) if block
      response
    else
      raise server_error(response)
    end
  end

  def path_to_payload(path)
    path = File.expand_path(path)
    type = MIME::Types.type_for(path)
    payload = {}
    payload[:input_file] = Faraday::UploadIO.new(path, type)
    payload
  end

  def server_error(response)
    return ServerSideError, "Error on server, responded #{ response.status } with message #{ response.body["error_message"]}."
  end
end