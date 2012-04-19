require 'spec_helper'

describe TmxDataUpdate::Updater do
  it "Should raise error if undo_update is not overriden" do
    expect{ TmxDataUpdate::Updater.new.undo_update }.to raise_error
  end

  it "Should raise error if perform_update is not overriden" do
    expect{ TmxDataUpdate::Updater.new.perform_update }.to raise_error
  end
end