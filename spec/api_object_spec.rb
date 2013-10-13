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
        @test_object = ApiObject.new
        @test_object.stubs(:endpoint).returns("test")
        @payload = { "test" => "bar" }
        @good_response_body = {
          "data" => {
            "uuid" => "test"
          }
        }
        @good_response = stub_response(200, {}, @good_response_body)
      end
      
      it 'should run to_server with the right arguments' do
        @test_object.expects(:to_server).with("/api/tests.json",@payload)
        @test_object.create_with_payload(@payload)
      end

      it 'should set self.uuid on success' do
        # TODO: More cleverly mock to_server
        connection = stub
        Miniphonic.stubs(:connect).returns(connection)
        connection.stubs(:post).returns(@good_response)
        @test_object.create_with_payload(@payload)
        @test_object.uuid.must_equal("test")
      end

    end

    describe '#command' do

      before do
        @payload = { "test" => "bar" }
        @test_object = ApiObject.new
        @test_object.stubs(:endpoint).returns("test_endpoint")
        @test_object.stubs(:uuid).returns("test_uuid")
        @command = "test_command"
      end

      it 'should run to_server with the right data' do
        @test_object.expects(:to_server).with("/api/test_endpoint/test_uuid/test_command.json", @payload)
        @test_object.command( @command, @payload )
      end

    end

  end
end