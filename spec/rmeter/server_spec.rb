require 'spec_helper'

describe Rmeter::Server do
  describe "/" do
    it "should glob all the JMeter data files" do
      Dir.should_receive(:[]).with( File.join(app.data, '*') ).and_return([])
      get '/'
    end

    it "should parse each of the data files" do
      files = [ '/foo/file_1.jml', '/foo/file_2.jml' ]
      Dir.stub!(:[]).and_return( files )

      parser_mocks = files.collect do |f|
        mock_parser = mock(Rmeter::Parser)
        mock_parser.should_receive(:parse).and_return({})
        Rmeter::Parser.should_receive(:new).with(f).and_return( mock_parser )
      end

      get '/'
    end
  end
end
