module Miniphonic
  
  describe Miniphonic do
  
    describe 'GET info' do

      before do
        require 'vcr'

        VCR.configure do |c|
          c.cassette_library_dir = 'test/spec/cassettes/info'
          c.hook_into :faraday
        end

      end
    
      describe '.services' do
      
        before do
          VCR.insert_cassette 'services'
        end

        after do
          VCR.eject_cassette
        end

        it 'won\'t fail' do
          response = Miniphonic.services
          response.success?.must_equal(true)
        end

        it 'must return an Array of Hashes' do
          Miniphonic.services.must_be_kind_of(Array)
          Miniphonic.services.each do |item|
            item.must_be_kind_of(Hash)
          end
        end

      end

      describe '.service_types' do
      
        before do
          VCR.insert_cassette 'service_types'
        end
      
        after do
          VCR.eject_cassette
        end

        it 'won\'t fail' do
          response = Miniphonic.service_types
          response.success?.must_equal(true)
        end
      
        it 'must return a hash' do
          Miniphonic.service_types.must_be_kind_of(Hash)
        end
      
      end

      describe '.algorithms' do
      
        before do
          VCR.insert_cassette 'algorithms'
        end
      
        after do
          VCR.eject_cassette
        end

        it 'won\'t fail' do
          response = Miniphonic.algorithms
          response.success?.must_equal(true)
        end
      
        it 'must return a hash' do
          Miniphonic.algorithms.must_be_kind_of(Hash)
        end
      
      end

      describe '.output_files' do
      
        before do
          VCR.insert_cassette 'output_files'
        end
      
        after do
          VCR.eject_cassette
        end

        it 'won\'t fail' do
          response = Miniphonic.output_files
          response.success?.must_equal(true)
        end
      
        it 'must return a hash' do
          Miniphonic.output_files.must_be_kind_of(Hash)
        end
      
      end

      describe '.status_codes' do
      
        before do
          VCR.insert_cassette 'status_codes'
        end
      
        after do
          VCR.eject_cassette
        end

        it 'won\'t fail' do
          response = Miniphonic.status_codes
          response.success?.must_equal(true)
        end
      
        it 'must return a hash' do
          Miniphonic.status_codes.must_be_kind_of(Hash)
        end
      
      end

      describe '.user_info' do
      
        before do
          VCR.insert_cassette 'user_info'
        end
      
        after do
          VCR.eject_cassette
        end

        it 'won\'t fail' do
          response = Miniphonic.user_info
          response.success?.must_equal(true)
        end
      
        it 'must return a hash' do
          Miniphonic.user_info.must_be_kind_of(Hash)
        end
      
      end

      describe '.info' do
      
        before do
          VCR.insert_cassette 'info'
        end
      
        after do
          VCR.eject_cassette
        end
      
        it 'won\'t fail' do
          response = Miniphonic.info
          response.success?.must_equal(true)
        end
        
        it 'must return a hash' do
          Miniphonic.info.must_be_kind_of(Hash)
        end
      
      end
      
    end
    
  end

end