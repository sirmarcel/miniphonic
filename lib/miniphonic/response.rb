require "multi_json"

# Proxy for a Faraday::Response
module Miniphonic 
  class Response
    extend Forwardable
    attr_reader :response

    def initialize(response)
      @response = response
    end

    def body
      @body ||= MultiJson.load(@response.body)
    end

    def data
      @data ||= @body["data"]
    end

    def_delegators @response, :status, :success?
  end
end