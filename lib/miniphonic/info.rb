module Miniphonic
  module Info
    # Methods to retrieve general information from auphonic

    include Miniphonic::Helpers

    # Returns an array of hashes like this:
    #  {
    #     "outgoing": true,
    #     "display_name": "Mr. Derpson",
    #     "uuid": "h8DesucEK6mepmyxtW83MY",
    #     "incoming": true,
    #     "type": "dropbox",
    #     "email": "me@derp.com"
    # }
    def services
      response = from_server "/api/services.json"
      response.data
    end

    # Returns a hash where the keys are outgoing services
    def service_types
      get_info :service_types
    end

    # Returns a hash where the keys are audio processing
    # algorithms and the values option/info hashes
    def algorithms
      get_info :algorithms
    end

    # Returns a hash of all available output formats (keys)
    # and their metadata (values)
    def output_files
      get_info :output_files
    end

    # Returns a dictionary of production status codes
    def status_codes
      get_info :production_status
    end

    # Returns a hash of user information
    def user_info
      response = from_server "api/user.json"
      response.data
    end

    # Returns a hash with the combined data of
    # output_files, service_types, status_codes, algorithms
    # as well as all known file endings (those are all keys)
    def info
      response = from_server "api/info.json"
      response.data
    end

    def files_on(uuid)
      response = from_server "api/service/#{ uuid }/ls.json"
      response.data
    end

    def get_info(name)
      response = from_server "/api/info/#{ name }.json"
      response.data
    end

  end
end