module Miniphonic
  class ApiObject

    attr_reader :uuid
    attr_accessor :meta

    def endpoint
      raise NotImplementedError, "#endpoint has to be overridden in #{ self.class.name }"
    end

    def create
      raise NotImplementedError, "#create has to be overridden in #{ self.class.name }"
    end


    def create_with_payload(payload)
      response = create_on_server(payload)
      if response.success?
        @uuid = response.data["uuid"]
      else
        raise error_message(response)
      end
    end

    def create_on_server(payload, connection = Miniphonic.connect)
      response = connection.post do |req|
       req.url "/api/#{ endpoint }.json"
       req.body = payload
      end
      Miniphonic::Response.new(response)
    end

    def error_message(response)
      "Error on server, responded #{ response.status } with message #{ response.body["error_message"]}."
    end


  end # class
end # module