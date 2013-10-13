require 'mime/types'

module Miniphonic::Helpers
  # Posts data to the server and executes a given block on success
  def to_server(url, payload = nil)
    connection = Miniphonic.connect

    raw_response = connection.post do |req|
      req.url url
      req.body = payload
    end

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