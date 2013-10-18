require_relative 'helper'

module Miniphonic

  describe Preset do

    before do
      require 'vcr'

      VCR.configure do |c|
        c.cassette_library_dir = 'test/spec/cassettes/preset'
        c.hook_into :faraday
      end

    end

    describe '.all' do
    
      before do
        VCR.insert_cassette 'all'
      end
    
      after do
        VCR.eject_cassette
      end
    
      it 'must return an array of presets' do
        Preset.all.each do |item|
          item.must_be_instance_of(Preset)
        end
      end
    
    end

    describe '#endpoint' do
    
      it 'must define the right endpoint' do
        Preset.new.endpoint.must_equal("preset")
      end
      
    end

    describe '#create' do

      before do
        VCR.insert_cassette 'create', :match_requests_on => [:body, :uri]
        @named_preset = Miniphonic::Preset.new
        @named_preset.name = "Test Preset"
      end

      after do
        VCR.eject_cassette
      end

      it "must raise an error if no name is provided" do
        lambda do
          Preset.new.create
        end.must_raise(PresetNameError)
      end

      it "must create a new preset on the server" do
        reponse = @named_preset.create
        reponse.success?.must_equal(true)
      end 

      it "must set self.uuid" do
        @named_preset.create
        @named_preset.uuid.wont_equal(nil)
      end

    end

    describe '#delete' do
    
      before do
        VCR.insert_cassette 'delete'
        @preset = Preset.new
        @preset.name = "To be deleted"
        @preset.create
      end
    
      after do
        VCR.eject_cassette
      end
    
      it 'must delete the preset' do
        response = @preset.delete
        response.success?.must_equal(true)
      end
    
    end

    describe '#upload_cover' do
    
      before do
        VCR.insert_cassette 'upload_cover', :match_requests_on => [:uri]
        @preset = Miniphonic::Preset.new
        @preset.name = "Test Upload Cover Preset"
        @preset.create
      end

      after do
        VCR.eject_cassette
      end

      it 'must upload a local image file' do
        reponse = @preset.upload_cover("test/spec/data/test.jpg")
        reponse.success?.must_equal(true)
      end

    end

  end

end