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
        good_body = {
          "data" => {
            "uuid" => "test"
          }
        }
        bad_body = {
          "error_message" => "trololo"
        }
        @good_response = Miniphonic::Response.new(stub_response(200, {}, good_body))
        @bad_response = Miniphonic::Response.new(stub_response(404, {}, bad_body))
        @object = ApiObject.new
      end

      it 'should set uuid if successful' do
        ApiObject.any_instance.expects(:create_on_server).returns(@good_response)
        @object.create_with_payload(nil)
        @object.uuid.must_equal("test")
      end

      it 'should raise an error if request fails' do
        ApiObject.any_instance.expects(:create_on_server).returns(@bad_response)
        lambda do
          @object.create_with_payload(nil)
        end.must_raise(RuntimeError)
      end
    end

    describe '#create_on_server' do

      before do
        @object = ApiObject.new
        @object.stubs(:endpoint).returns("test")
        @connection = mock
        @response = stub_response(200, {})
      end

      it 'should post' do
        @connection.expects(:post).returns(@response)
        @object.create_on_server({}, @connection)
      end

      # TODO: Actually mock a real connection and verify the sent data. That is, however, beyond my powers.
    end

  end
end