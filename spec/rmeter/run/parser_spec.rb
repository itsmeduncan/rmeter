require 'spec_helper'

describe Rmeter::Run::Parser do
  describe "#parse" do
    it "should return an array of hashes with the parsed values" do
      xml =<<XML
      <?xml version="1.0" encoding="UTF-8"?>
      <testResults version="1.2">
      <httpSample t="780" lt="746" ts="1309493042836" s="true" lb="Home Page" rc="200" rm="OK" tn="First Group 1-1" dt="text" by="9861"/>
      </testResults>
XML
      File.should_receive(:open).with('/some/file/path.xml').and_return(StringIO.new(xml))
      Rmeter::Run::Parser.new('/some/file/path.xml').parse.should == [
        {
          :time => 780,
          :latency => 780,
          :timestamp => Time.at(1309493042836 / 1000),
          :success => true,
          :label => 'Home Page',
          :response_code => 200,
          :response_message => 'OK',
          :thread_name => 'First Group 1-1',
          :bytes => 9861
        }
      ]
    end
  end
end
