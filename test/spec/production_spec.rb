require_relative 'helper'

module Miniphonic

  describe Production do
  
    before do
      require 'vcr'

      VCR.configure do |c|
        c.cassette_library_dir = 'test/spec/cassettes/production'
        c.hook_into :faraday
      end

    end

    describe '#create' do

      before do
        VCR.insert_cassette 'create', :match_requests_on => [:body, :uri]
        @production = Miniphonic::Production.new
      end

      after do
        VCR.eject_cassette
      end

      it "must create a new production on the server" do
        reponse = @production.create
        reponse.success?.must_equal(true)
      end 

      it "must set self.uuid" do
        @production.create
        @production.uuid.wont_equal(nil)
      end

    end

    describe '#upload_file_from_service' do
    
      before do
        VCR.insert_cassette 'upload_file_from_service', :match_requests_on => [:body, :uri]
        @production = Production.new
        @production.create
        @test_file = "test.m4a"
        @service_uuid = "h8DesucEK6mepmyxtW83MY"
      end

      after do
        VCR.eject_cassette
      end

      it 'must add an input file from an external service' do
        response = @production.upload_file_from_service(@test_file, @service_uuid)
        response.success?.must_equal(true)
      end
    end

    describe '#upload' do
    
      before do
        VCR.insert_cassette 'upload', :match_requests_on => [:body, :uri]
        @production = Miniphonic::Production.new
        @production.create
      end

      after do
        VCR.eject_cassette
      end

      it 'must upload a local file' do
        reponse = @production.upload("test/spec/data/test.m4a")
        reponse.success?.must_equal(true)
      end

    end
    
  end

end