module Miniphonic
  class Production < ApiObject
    def endpoint
      "production"
    end

    attr_accessor :preset
    attr_accessor :meta
    attr_accessor :outfiles
    attr_reader :uuid

    def initialize(uuid = nil)
      @uuid = uuid
      @outfiles = []
      @meta = []
    end

    def create
      create_with_payload(to_payload)
    end
  
    def upload(path)
      command :upload, path_to_payload(path)
    end

    def start
      command :start
    end

    def set_outfiles
      command :output_files, @outfiles
    end

    def to_payload
      payload = {}
      payload["preset"] = @preset if @preset
      payload["metadata"] = @meta
      payload
    end

  end
end