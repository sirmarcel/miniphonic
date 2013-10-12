require "multi_json"

# Proxy for a Faraday::Response
module Miniphonic 
  class Response
    extend Forwardable
    attr_reader :response, :body, :data

    def initialize(response)
      @response = response
      @data = response.body["data"]
    end

    def_delegators :@response, :status, :success?, :body
  end
end