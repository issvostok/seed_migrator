require 'spec_helper'

describe TmxDataUpdate do
  before :all do

    class UpdateStub
      include TmxDataUpdate

      def root_updates_path
        "#{File.dirname(__FILE__)}/sample"
      end

      def should_run?(update_name)
        update_name != '03_foo_update'
      end
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
    @up.apply_update('03_foo_update').should be_nil
  end

  it "run condition should prevent revert from running" do
    @up.revert_update('03_foo_update').should be_nil
  end

  it 'Should raise a LoadError if given an update that does not exist, even if it does not run' do
    expect{
      @up.apply_update('bar')
    }.to raise_error(LoadError)
  end
end