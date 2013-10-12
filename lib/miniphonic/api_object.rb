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
        error_message = MultiJson.load(response.body)
        raise "Error on server, responded #{ response.status } with message #{ response.body["error_message"]}."
      end
    end

    def create_on_server(payload)
      reponse = @connection.post do |req|
       req.url '/api/#{ endpoint }.json'
       req.headers['Content-Type'] = 'application/json'
       req.body = MultiJson.dump(payload)
      end
      Miniphonic::Response(response)
    end


  end # class
end # module