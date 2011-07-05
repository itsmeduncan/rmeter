module Rmeter
  class Aggregator
    attr_reader :files

    def initialize(pattern)
      @files = Dir[pattern]
    end

    def time_by_url
      series = data.group_by { |d| d[:url] }
      series.map do |url, data|
        { :name => url[0..30], :data => data.map { |d| [ d[:timestamp].to_i * 1000, d[:time] ] } }
      end
    end

    def data
      files.collect { |f| Rmeter::Parser.new(f).parse }.flatten
    end
  end
end