require 'spec_helper'

describe TmxDataUpdate::Seeds do

  before :all do
    class SeedsStub
      include TmxDataUpdate::Seeds
    end

    @ss = SeedsStub.new
    @path = "#{File.dirname(__FILE__)}/sample"
  end

  it "Should apply all updates in a directory" do
    buffer = @ss.apply_updates(@path)
    buffer.size.should == 2
    buffer['sample_update'].should == 'perform_update'
    buffer['01_sequenced_update'].should == 'perform sequenced update'
  end

end