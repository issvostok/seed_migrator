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
    buffer.size.should == 3
    buffer['sample_update'].should == 'perform_update'
    buffer['01_sequenced_update'].should == 'perform sequenced update'
    buffer['02_another_update'].should == 'perform another update'
  end

  it "Should load update files in order" do
    files = @ss.send(:get_update_files, @path)
    files.should == %w(01_sequenced_update.rb 02_another_update.rb sample_update.rb)
  end

end