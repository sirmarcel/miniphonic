require_relative 'production_attributes'

module Miniphonic
  class Preset < ApiObject
    include Attributes::Preset

    def endpoint
      "preset"
    end

  end
end