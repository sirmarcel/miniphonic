require_relative 'helper'
require 'multi_json'

module Miniphonic

  describe Response do
    before do
      @response_body = { 
        "status" => "200",
        "data" => {
          "test" => "toast"
        }
      }
      stubs = Faraday::Adapter::Test::Stubs.new
      stubs.get('/win'){[200, {}, MultiJson.dump(@response_body)]}
      test = Faraday.new do |builder|
        builder.adapter :test, stubs
      end
      raw_response = test.get '/win'
      @response = Miniphonic::Response.new(raw_response)
    end

    describe '#body' do
      it 'should parse the body into a hash' do
        @response.body.must_equal(@response_body)
      end
    end

    describe '#data' do
      it 'should take the data out of the body' do
        @response.data.must_equal(@response_body["data"])
      end
    end
  end
end