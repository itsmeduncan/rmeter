require 'spec_helper'

describe Rmeter::Parser do
  describe "#parse" do
    before :all do
      @xml =<<XML
      <?xml version="1.0" encoding="UTF-8"?>
      <testResults version="1.2">
      <httpSample t="494" lt="473" ts="1309735429539" s="true" lb="Home Page" rc="200" rm="OK" tn="First Group 1-1" dt="text" by="9711">
        <java.net.URL>http://www.google.com/</java.net.URL>
      </httpSample>
XML
    end

    {
      :time => 494,
      :latency => 473,
      :timestamp => Time.at(1309735429539 / 1000),
      :success => true,
      :label => 'Home Page',
      :response_code => 200,
      :response_message => 'OK',
      :thread_name => 'First Group 1-1',
      :bytes => 9711
    }.each do |attribute, value|
      it "should parse out the #{attribute} attribute" do
        File.stub!(:open).with('/some/file/path.xml').and_return(StringIO.new(@xml))
        Rmeter::Parser.new('/some/file/path.xml').parse.first[attribute].should == value
      end
    end

    it "should parse the URL" do
      File.stub!(:open).with('/some/file/path.xml').and_return(StringIO.new(@xml))
      Rmeter::Parser.new('/some/file/path.xml').parse.first[:url].should == 'http://www.google.com/'
    end
  end
end
