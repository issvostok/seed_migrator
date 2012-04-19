require 'spec_helper'

describe TmxDataUpdate do
  before :all do
    TmxDataUpdate.root_updates_path = "#{File.dirname(__FILE__)}/sample"
    class UpdateStub
      include TmxDataUpdate
    end

    @up = UpdateStub.new
  end

  it "Should apply updates" do
    @up.apply_update(:sample_update).should == 'perform_update'
  end

  it "Should revert updates" do
    @up.revert_update(:sample_update).should == 'undo_update'
  end
end