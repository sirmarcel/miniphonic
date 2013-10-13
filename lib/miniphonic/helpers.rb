require 'mime/types'

module Miniphonic::Helpers

  # TODO: abstract to and from server into something like "request(verb, url, payload)"
  # Problem: Passing the blocks around in a performing way (&block is sloooow)

  # Posts data to the server and executes a given block on success
  def to_server(url, payload = {})
    connection = Miniphonic.connect

    raw_response = connection.post url, payload
    response = Miniphonic::Response.new(raw_response)

    if response.success?
      yield(response) if block_given?
      response
    else
      raise server_error(response)
    end
  end

  # Gets data from the server and executes a given block on success
  def from_server(url, payload = {})
    connection = Miniphonic.connect
    
    raw_response = connection.get url, payload
    response = Miniphonic::Response.new(raw_response)

    if response.success?
      yield(response) if block_given?
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
    "Error on server, responded #{ response.status } with message #{ response.body["error_message"]}."
  end
end