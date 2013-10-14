require 'minitest/autorun'
require 'miniphonic'
require 'mocha/setup'
# require 'webmock/minitest'
# require 'vcr'

# VCR.configure do |c|
#       c.cassette_library_dir = 'fixtures/vcr_cassettes'
#       c.hook_into :faraday
#       c.stub_with :webmock
#   end

begin
  require 'minitest/pride'
rescue LoadError
  # No colours, but don't break
end

def stub_response(status, headers, body = {})
  stubs = create_stub_adapter
  stubs.get('/'){[status, headers, body]}
  test = Faraday.new do |builder|
    builder.use FaradayMiddleware::ParseJson
    builder.use FaradayMiddleware::EncodeJson
    builder.adapter :test, stubs
  end
  test.get '/'
end

def create_stub_adapter
  Faraday::Adapter::Test::Stubs.new
end