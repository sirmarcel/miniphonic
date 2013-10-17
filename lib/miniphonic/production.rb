require_relative 'production_attributes'

module Miniphonic
  class Production < ApiObject
    include Attributes::Production

    def endpoint
      "production"
    end

    def upload_audio(path)
      command :upload, path_to_payload(path, :input_file)
    end

    # If your file is on a service registered with Auphonic,
    # use this to not have to upload by hand.

    def create_with_file_from_service(filename, service)
      self.input_file = filename
      self.service = service
      create
    end

    def upload_file_from_service(filename, service)
      self.input_file = filename
      self.upload_service = service
      update
    end

    def start
      command :start
    end

    def stop
      command :stop
    end

  end
end