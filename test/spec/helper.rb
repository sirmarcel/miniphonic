require 'minitest/autorun'
require 'miniphonic'
require 'mocha/setup'

begin
  require 'minitest/pride'
rescue LoadError
  # No colours, but don't break
end

# VCR will not throw errors if the authentication is wrong, 
# so you only need to supply credentials for recording

Miniphonic.configure do |m|
  m.user = "sirmarcel"
  m.password = "not telling"
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