require 'mime/types'

module Miniphonic::Helpers

  # Posts data to the server and executes a given block on success
  def to_server(url, payload = {}, &block)
    connection = Miniphonic.connect
    response = connection.post url, payload
    handle_response(response, &block)
  end

  # Gets data from the server and executes a given block on success
  def from_server(url, payload = {}, &block)
    connection = Miniphonic.connect
    response = connection.get url, payload
    handle_response(response, &block)
  end

  # Deletes data from the server and executes a given block on success
  def delete_from_server(url, payload = {}, &block)
    connection = Miniphonic.connect
    response = connection.delete url, payload
    if response.success?
      block.call(response) if block
      response
    else
      server_error(response)
    end
  end

  def handle_response(response, &block)
    if response.success?
      block.call(response) if block
      response
    else
      server_error(response)
    end
  end

  def path_to_payload(path, type)
    path = File.expand_path(path)
    filetype = MIME::Types.type_for(path)
    payload = {}
    payload[type] = Faraday::UploadIO.new(path, filetype)
    payload
  end

  def server_error(response)
    raise Miniphonic::ServerSideError, "Error on server, responded #{ response.status } with message #{ response.body["error_message"]}."
  end
end