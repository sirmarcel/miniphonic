module Miniphonic
  module Attributes
    module Preset
      # Slightly tedious, but very non-magic way of defining the API

      attr_accessor :preset_name

      def metadata
        @metadata ||= {}
      end

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

      def multi_input_files
        @multi_input_files ||= []
      end

      def attributes_to_payload
        payload = {}
        payload[:preset_name] = preset_name if preset_name
        payload[:metadata] = metadata unless metadata.empty?
        payload[:output_basename] = output_basename if output_basename
        payload[:output_files] = output_files unless output_files.empty?
        payload[:outgoing_services] = outgoing_services unless outgoing_services.empty?
        payload[:algorithms] = algorithms unless algorithms.empty?
        payload[:multi_input_files] = multi_input_files unless multi_input_files.empty?
        payload
      end

      def payload_to_attributes(payload)
        @metadata = payload["metadata"]
        @preset_name = payload["preset_name"]
        @output_basename = payload["output_basename"]
        @output_files = payload["output_files"]
        @outgoing_services = payload["outgoing_services"]
        @algorithms = payload["algorithms"]
        @multi_input_files = payload["multi_input_files"]
      end
    end
  end
end