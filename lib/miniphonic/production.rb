require 'mime/types'

module Miniphonic
  class Production < ApiObject
    def endpoint
      "productions"
    end

    attr_accessor :preset
    attr_accessor :meta
    attr_accessor :outfiles
    attr_reader :uuid

    def initialize(uuid = nil)
      @uuid = uuid
      @outfiles = []
    end

    def create
      payload = to_payload
      create_with_payload(payload)
    end
  
    def to_payload
      payload = {}
      payload["preset"] = @preset if @preset
      payload["metadata"] = @meta
      payload
    end

    def upload(path)
      path = File.expand_path(path)
      type = MIME::Types.type_for(path)
      payload = {}
      payload[:input_file] = Faraday::UploadIO.new(path, type)
      connection = Miniphonic.connect
      response = connection.post "/api/production/#{ @uuid }/upload.json", payload
      response = Miniphonic::Response.new(response)
      raise error_message(response) unless response.success?
    end

    def start
      response = Miniphonic.connect.post "/api/production/#{ @uuid }/start.json"
      response = Miniphonic::Response.new(response)
      raise error_message(response) unless response.success?
    end

    def set_outfiles
      payload = @outfiles
      response = Miniphonic.connect.post "/api/production/#{ @uuid }/output_files.json" do |req|
        req.url "/api/production/#{ @uuid }/output_files.json"
        req.body = payload
      end
      response = Miniphonic::Response.new(response)
      raise error_message(response) unless response.success?
    end
  end
end