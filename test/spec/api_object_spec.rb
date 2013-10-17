require_relative 'helper'
require 'multi_json'

module Miniphonic

  describe ApiObject do
    
    describe '#endpoint' do
      it 'must raise an error if no endpoint is defined' do
        lambda do
          ApiObject.new.endpoint
        end.must_raise(NotImplementedError)
      end
    end

    describe '#attributes_to_payload' do
      
      it 'must raise an error if no attributes_to_payload method is defined' do
        lambda do
          ApiObject.new.attributes_to_payload
        end.must_raise(NotImplementedError)
      
      end
    end

    describe '#payload_to_attributes' do
      
      it 'must raise an error if no payload_to_attributes method is defined' do
        lambda do
          ApiObject.new.payload_to_attributes({})
        end.must_raise(NotImplementedError)
      
      end

    end

    describe '#initialize' do
    
      it 'must initialize object with uuid' do
        ApiObject.new("test").uuid.must_equal("test")
      end
      
    end

    describe '#create' do
      
      before do
        @test_object = ApiObject.new
        @test_object.stubs(:collection_url).returns("test")
        @payload = { "test" => "bar" }
        @collection_url = "/api/test"
        @good_response_body = {
          "data" => {
            "uuid" => "test"
          }
        }
        @good_response = stub_response(200, {}, @good_response_body)

        # Stub to_server interna (not very elegantly)
        @connection = stub
        Miniphonic.stubs(:connect).returns(@connection)
        @connection.stubs(:post).returns(@good_response)
      end
      
      it 'must run to_server with the right arguments' do
        @test_object.stubs(:collection_url).returns(@collection_url)
        @test_object.stubs(:attributes_to_payload).returns(@payload)
        @test_object.expects(:to_server).with(@collection_url,@payload)
        @test_object.create
      end

      it 'must set self.uuid on success' do
        @test_object.stubs(:collection_url).returns(@collection_url)
        @test_object.stubs(:attributes_to_payload).returns(@payload)
        @test_object.create
        @test_object.uuid.must_equal("test")
      end

    end

    describe '#update' do
    
      before do
        @test_object = ApiObject.new
        @payload = {test: "foo"}
        @url = "/test"
        @test_object.stubs(:attributes_to_payload).returns(@payload)
        @test_object.stubs(:single_url).returns(@url)
      end

      it 'must call to_server with the right data' do
        @test_object.expects(:to_server).with(@url, @payload)
        @test_object.update
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

      it 'must run to_server with the right data' do
        @test_object.expects(:to_server).with("/api/test_endpoint/test_uuid/test_command.json", @payload)
        @test_object.command( @command, @payload )
      end

    end

    describe '#get_attributes' do
    
      before do
        @single_url = "/api/test"
        @data_on_server = {test: "toast"}
        @response_body = {
          "data" => @data_on_server
        }

        @test_object = ApiObject.new
        @test_object.stubs(:single_url).returns(@single_url)
        
        
        @response = stub_response(200, {}, @response_body)

        # Stub from_server interna (not very elegantly)
        @connection = stub
        Miniphonic.stubs(:connect).returns(@connection)
        @connection.stubs(:get).returns(@response)
      end

      it 'must pass data from server to attributes_to_payload' do
        @test_object.expects(:payload_to_attributes).with(@data_on_server)
        @test_object.get_attributes
      end
      
    end

    describe '#single_url' do
    
      it 'must raise error if no uuid is present' do
        lambda do
          Production.new.single_url
        end.must_raise(UuidError)
      end
      
    end

    describe '#command_url' do
    
      it 'must raise error if no uuid is present' do
        lambda do
          Production.new.command_url("")
        end.must_raise(UuidError)
      end
      
    end

  end
end