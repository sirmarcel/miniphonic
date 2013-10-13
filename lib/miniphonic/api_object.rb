module Miniphonic
  class ApiObject
    include Miniphonic::Helpers

    attr_accessor :uuid

    def endpoint
      raise NotImplementedError, "#endpoint has to be overridden in #{ self.class.name }"
    end

    def create
      raise NotImplementedError, "#create has to be overridden in #{ self.class.name }"
    end

    def attributes_to_payload
      raise NotImplementedError, "#create has to be overridden in #{ self.class.name }"
    end

    def create_with_payload(payload)
      to_server("/api/#{ collection_endpoint }.json", payload) do |response|
        self.uuid = response.data["uuid"]
      end
    end

    def command(command, payload = nil)
      url = "/api/#{ endpoint }/#{ self.uuid }/#{ command }.json"
      to_server url, payload
    end

    def collection_endpoint
      endpoint + "s"
    end

    def data
      @data ||= {}
    end

  end # class
end # module