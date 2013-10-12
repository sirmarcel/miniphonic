require "multi_json"

# Proxy for a Faraday::Response
module Miniphonic 
  class Response
    extend Forwardable
    attr_reader :response, :body, :data

    def initialize(response)
      @response = response
      @body = MultiJson.load(@response.body)
      @data = @body["data"]
    end

    def_delegators :@response, :status, :success?
  end
end