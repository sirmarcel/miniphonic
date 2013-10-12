require 'minitest/autorun'
require 'miniphonic'

begin
  require 'minitest/pride'
rescue LoadError
  # No colours, but don't break
end

def stub_response(status, headers, body = "")
  stubs = Faraday::Adapter::Test::Stubs.new
  stubs.get('/'){[status, headers, MultiJson.dump(body)]}
  test = Faraday.new do |builder|
    builder.adapter :test, stubs
  end
  test.get '/'
end