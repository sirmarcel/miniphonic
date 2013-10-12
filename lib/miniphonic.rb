require "miniphonic/version"
require "miniphonic/response"
require "faraday"

module Miniphonic
  class << self
    attr_accessor :user, :password

    def configure
      yield self
    end

    def connect
      connection = Faraday.new(url: 'https://auphonic.com')
      connection.basic_auth Auphonic.user, Auphonic.password
      connection
    end
  end
end