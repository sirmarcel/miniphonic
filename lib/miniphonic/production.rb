require_relative 'production_attributes'

module Miniphonic
  class Production < ApiObject
    include Attributes::Production

    def endpoint
      "production"
    end

    def initialize(uuid = nil)
      @uuid = uuid
    end

    def create
      create_with_payload(attributes_to_payload)
    end
  
    def upload(path)
      command :upload, path_to_payload(path)
    end

    def start
      command :start
    end

    def set_output_files
      command :output_files, self.output_files
    end

  end
end