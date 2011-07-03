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

      files.each { |f| Rmeter::Parser.should_receive(:new).with(f) }
      get '/'
    end
  end
end
