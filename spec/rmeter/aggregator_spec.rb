require 'spec_helper'

describe Rmeter::Aggregator do
  describe "#new" do
    it "should glob the directory with the given pattern" do
      Dir.should_receive(:[]).with('/some/pattern/*')
      Rmeter::Aggregator.new('/some/pattern/*')
    end
  end

  describe "#time_by_url" do
    xit "should return an array with hashes of :name and :data keys"
    xit "should convert the timestamp from milliseconds to seconds"

    it "should group time data series by url" do
      Dir.stub!(:[]).and_return( ['file_1.jml', 'file_2.jml'] )
      Rmeter::Parser.stub!(:new).
                     with('file_1.jml').
                     and_return( mock( Rmeter::Parser, :parse => [ {:url => 'a'}, {:url => 'b'} ] ) )
      Rmeter::Parser.stub!(:new).
                     with('file_2.jml').
                     and_return( mock( Rmeter::Parser, :parse => [ {:url => 'a'} ] ) )

      series = Rmeter::Aggregator.new(anything).time_by_url
      series.find { |set| set[:name] == 'a' }[:data].count.should == 2
      series.find { |set| set[:name] == 'b' }[:data].count.should == 1
    end

    it "should do something" do
      
    end
  end

  describe "#data" do
    it "should parse each of the data files" do
      files = ['file_1.jml', 'file_2.jml']
      Dir.stub!(:[]).and_return(files)

      files.collect do |f|
        mock_parser = mock(Rmeter::Parser)
        mock_parser.should_receive(:parse).and_return({})
        Rmeter::Parser.should_receive(:new).with(f).and_return(mock_parser)
      end

      Rmeter::Aggregator.new(files).data
    end

    it "should flatten the results" do
      Dir.stub!(:[]).and_return(['file_1.jml', 'file_2.jml'])
      Rmeter::Parser.should_receive(:new).
                     with('file_1.jml').
                     and_return( mock(Rmeter::Parser, :parse => [:foo, :bar]) )
      Rmeter::Parser.should_receive(:new).
                     with('file_2.jml').
                     and_return( mock(Rmeter::Parser, :parse => [:baz]) )

      Rmeter::Aggregator.new(anything).data.should == [:foo, :bar, :baz]
    end
  end
end
