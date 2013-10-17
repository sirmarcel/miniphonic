require_relative 'preset_attributes'

module Miniphonic
  class Preset < ApiObject
    include Attributes::Preset

    def endpoint
      "preset"
    end

    def create
      raise PresetNameError, "You can't create a preset without setting preset.name first." unless name
      super
    end

  end
end