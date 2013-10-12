module Miniphonic
  class Production
    def endpoint
      "productions"
    end

    attr_accessor :preset
    attr_accessor :meta

    def create
      payload = to_payload
    end
  
    def to_payload
      payload = {}
      payload["preset"] = @preset if @preset
      payload["metadata"] = @meta
      payload
    end
  end
end