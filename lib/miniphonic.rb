require "faraday"
require "faraday_middleware"

require "miniphonic/version"
require "miniphonic/helpers"
require "miniphonic/response"
require "miniphonic/api_object"
require "miniphonic/production"
require "miniphonic/preset"
require "miniphonic/info"

module Miniphonic
  extend Miniphonic::Info

  class UuidError < StandardError
  end
  class ServerSideError < StandardError
  end
  class PresetNameError < StandardError
  end

  class << self
    attr_accessor :user, :password

    def configure
      yield self
    end

    def connect
      connection = Faraday.new(url: 'https://auphonic.com') do |con|
        con.request :multipart
        con.use FaradayMiddleware::ParseJson
        con.use FaradayMiddleware::EncodeJson
        con.adapter :net_http
      end
      connection.basic_auth user, password
      connection
    end
  end
end