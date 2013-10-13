module Miniphonic
  class ApiObject
    include Miniphonic::Helpers

    attr_reader :uuid
    attr_accessor :meta

    def endpoint
      raise NotImplementedError, "#endpoint has to be overridden in #{ self.class.name }"
    end

    def create
      raise NotImplementedError, "#create has to be overridden in #{ self.class.name }"
    end

    def create_with_payload(payload)
      to_server("/api/#{ collection_endpoint }.json", payload) do |response|
        @uuid = response.data["uuid"]
      end
    end

    def command(command, payload = nil)
      url = "/api/#{ endpoint }/#{ @uuid }/#{ command }.json"
      to_server url, payload
    end

    def collection_endpoint
      endpoint + "s"
    end
    
  end # class
end # module