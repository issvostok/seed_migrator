require 'spec_helper'

describe SeedMigrator::Updater do
  it "Should raise error if undo_update is not overriden" do
    expect{ SeedMigrator::Updater.new.undo_update }.to raise_error
  end

  it "Should raise error if perform_update is not overriden" do
    expect{ SeedMigrator::Updater.new.perform_update }.to raise_error
  end

  context 'when #execute is called' do
    before { @updater = Class.new(SeedMigrator::Updater).new }


    it 'Should be delegated' do
      @updater.should respond_to(:execute)
    end

    it 'Should be delegated to ActiveRecord::Base.connection' do
      ActiveRecord::Base.stub_chain(:connection, :execute).with(:foo).and_return(:bar)

      @updater.execute(:foo).should == :bar
    end
  end
end
