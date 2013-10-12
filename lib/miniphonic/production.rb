module Miniphonic
  class Production < ApiObject
    def endpoint
      "productions"
    end

    attr_accessor :preset
    attr_accessor :meta

    def create
      payload = to_payload
      create_with_payload(payload)
    end
  
    def to_payload
      payload = {}
      payload["preset"] = @preset if @preset
      payload["metadata"] = @meta
      payload
    end
  end
end