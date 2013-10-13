require_relative 'production_attributes'

module Miniphonic
  class Production < ApiObject
    include Attributes::Production

    def endpoint
      "production"
    end

    def upload(path)
      command :upload, path_to_payload(path)
    end

    def start
      command :start
    end

    def stop
      command :stop
    end

  end
end