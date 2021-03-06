module Miniphonic
  class ApiObject
    include Miniphonic::Helpers
    extend Miniphonic::Helpers

    class << self
      
      def all
        from_server self.new.collection_url do |response|    
          return response.data.each_with_object([]) do |hash, objects|
            objects << self.new(hash["uuid"])
          end
        end
      end

    end

    attr_accessor :uuid

    def endpoint
      raise NotImplementedError, "#endpoint has to be overridden in #{ self.class.name }"
    end

    def attributes_to_payload
      raise NotImplementedError, "#create has to be overridden in #{ self.class.name }"
    end

    def payload_to_attributes(payload)
      raise NotImplementedError, "#attributes_to_payload has to be overridden in #{ self.class.name }"
    end

    def initialize(uuid = nil)
      @uuid = uuid
    end

    # Create an API object on server, will conveniently send already set attributes
    def create
      to_server(collection_url, attributes_to_payload) do |response|
        self.uuid = response.data["uuid"]
      end
    end

    # Reset the API object on server and replaces with current attributes
    # (We can do this brute-force thing because we have local state.)
    def update
      url = single_url
      payload = attributes_to_payload
      payload[:reset_data] = true
      to_server url, payload
    end

    # Update the local API object with the data from the server
    # (Mostly to be used after ApiObject.new(uuid))
    def get_attributes
      from_server single_url do |response|
        payload_to_attributes(response.data)
      end
    end

    def upload_cover(path)
      command :upload, path_to_payload(path, :image)
    end

    # Delete API object from server    
    def delete
      delete_from_server single_url
    end

    def command(command, payload = nil)
      url = command_url(command)
      to_server url, payload
    end

    def collection_endpoint
      endpoint + "s"
    end

    # URLs

    def collection_url
      "/api/#{ collection_endpoint }.json"
    end

    def single_url
      raise UuidError unless self.uuid
      "/api/#{ endpoint }/#{ self.uuid }.json"
    end

    def command_url(command)
      raise UuidError unless self.uuid
      "/api/#{ endpoint }/#{ self.uuid }/#{ command }.json"
    end

  end # class
end # module