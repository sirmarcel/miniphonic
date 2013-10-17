module Miniphonic
  module Attributes
    module Production
      # Slightly tedious, but very non-magic way of defining the API

      def metadata
        @metadata ||= {}
      end

      attr_accessor :preset

      attr_accessor :output_basename

      def output_files
        @output_files ||= []
      end

      def outgoing_services
        @outgoing_services ||= []
      end

      def algorithms
        @algorithms ||= {}
      end

      def chapters
        @chapters ||= {}
      end

      attr_accessor :input_file
      attr_accessor :upload_service

      def multi_input_files
        @multi_input_files ||= []
      end

      def attributes_to_payload
        payload = {}
        payload[:metadata] = metadata unless metadata.empty?
        payload[:preset] = preset if preset
        payload[:output_basename] = output_basename if output_basename
        payload[:output_files] = output_files unless output_files.empty?
        payload[:outgoing_services] = outgoing_services unless outgoing_services.empty?
        payload[:algorithms] = algorithms unless algorithms.empty?
        payload[:chapters] = chapters unless chapters.empty?
        payload[:input_file] = input_file if input_file
        payload[:service] = upload_service if upload_service
        payload[:multi_input_files] = multi_input_files unless multi_input_files.empty?
        payload
      end

      def payload_to_attributes(payload)
        @metadata = payload["metadata"]
        @preset = payload["preset"]
        @output_basename = payload["output_basename"]
        @output_files = payload["output_files"]
        @outgoing_services = payload["outgoing_services"]
        @algorithms = payload["algorithms"]
        @chapters = payload["chapters"]
        @input_file = payload["input_file"]
        @upload_service = payload["service"]
        @multi_input_files = payload["multi_input_files"]
      end
    end
  end
end