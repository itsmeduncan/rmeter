module Rmeter
  class Parser
    ATTRIBUTE_MAPPING = {
      't' => :time,
      'lt' => :latency,
      'ts' => :timestamp,
      's' => :success,
      'lb' => :label,
      'rc' => :response_code,
      'rm' => :response_message,
      'tn' => :thread_name,
      'b' => :bytes
    }

    attr_reader :file

    def initialize(file)
      @file = file
    end

    def parse
      @doc = Nokogiri::XML(File.open(file))
      @doc.xpath('/testResults/httpSample').collect do |result|
        result.attribute_nodes.each_with_object({}) do |node, results|
          key = ATTRIBUTE_MAPPING[node.name]
          converter = "convert_#{key}".to_sym

          results[key] = respond_to?(converter, true) ? send(converter, node.value) : node.value if key
        end
      end
    end

    private
      def to_i(value)
        value.to_i
      end
      [ :time, :latency, :response_code, :bytes ].each { |name| alias :"convert_#{name}" :to_i }

      def convert_timestamp(timestamp)
        Time.at(timestamp.to_i / 1000)
      end

      def convert_success(success)
        (success == 'true') ? true : false
      end
  end
end