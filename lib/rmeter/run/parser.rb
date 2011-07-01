module Rmeter
  module Run
    class Parser
      ATTRIBUTE_MAPPING = {
        't' => :time,
        'lt' => :latency,
        'ts' => :timestamp,
        's' => :success,
        'lb' => :label,
        'rc' => :response_code,
        'rm' => :response_message,
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
            results[key] = node.value if key
          end
        end
      end

      private
        def convert_timestamp(timestamp)
          Time.at(timestamp.to_i / 10000)
        end
    end
  end
end