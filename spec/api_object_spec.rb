require_relative 'helper'
require 'multi_json'

module Miniphonic

  describe ApiObject do
    
    describe '#endpoint' do
      it 'should raise an error if no endpoint is defined' do
        lambda do
          ApiObject.new.endpoint
        end.must_raise(NotImplementedError)
      end
    end

    describe '#create' do
      it 'should raise an error if no create method is defined' do
        lambda do
          ApiObject.new.create
        end.must_raise(NotImplementedError)
      end
    end

    describe '#create_with_payload' do
      before do
        body = {
          "data" => {
            "uuid" => "test"
          }
        }
        @response = Miniphonic::Response.new(stub_response(200, {}, body))
      end

      it 'should set uuid if successful' do
        ApiObject.any_instance.expects(:create_on_server).returns(@response)
        object = ApiObject.new
        object.create_with_payload("")
        object.uuid.must_equal("test")
      end
    end

  end
end