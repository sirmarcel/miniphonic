require "miniphonic/version"
require "miniphonic/response"
require "miniphonic/api_object"
require "miniphonic/production"
require "faraday"

module Miniphonic
  class << self
    attr_accessor :user, :password

    def configure
      yield self
    end

    def connect
      connection = Faraday.new(url: 'https://auphonic.com') do |con|
        con.request :multipart
        con.adapter :net_http
      end
      connection.basic_auth user, password
      connection
    end
  end
end