require 'spec_helper'

describe TmxDataUpdate do
  before :all do
    TmxDataUpdate.root_updates_path = "#{File.dirname(__FILE__)}/sample"
    TmxDataUpdate.set_run_condition{|update|
      update != 'foo'
    }
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

  it "Should apply updates if the updates have a prefix" do
    @up.apply_update('01_sequenced_update').should == 'perform sequenced update'
  end

  it "run condition should prevent apply from running" do
    @up.apply_update('foo').should be_nil
  end

  it "run condition should prevent revert from running" do
    @up.revert_update('foo').should be_nil
  end
end