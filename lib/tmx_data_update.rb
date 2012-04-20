require 'active_support/all' # Should be required first.
require 'tmx_data_update/update_class_loader' #Should be required second.

require 'tmx_data_update/updater'
require 'tmx_data_update/seeds'

# Extends the migrations DSL to include the functionality to execute data updates.
module TmxDataUpdate
  include TmxDataUpdate::UpdateClassLoader

  # Sets the root path where the data updates are expected to be stored.
  # @param [Pathname|String|Symbol] path
  def self.root_updates_path=(path)
    @root_path = path
  end

  # Returns the currently set root data updates path.
  def self.root_updates_path
    @root_path
  end

  # Sets a block that will be called every time we call apply_update or
  # revert_update.  If the block returns true, the operation will proceed,
  # otherwise we return early.
  # @param |Block| &block
  def self.set_run_condition(&block)
    @block = block
  end

  # Return +true+ if the named update should run, +false+ otherwise.  If
  # a block was set via set_run_condition, will call that block, otherwise will
  # always return +true+.
  def self.should_run?(update_name)
    if @block
      !!@block.call(update_name)
    else
      true
    end
  end

  # Overriden to check if the root_updates_path has already been set.
  # @param [Class] base
  def self.included(base)
    if root_updates_path.nil?
      puts "Warning: TmxDataUpdate#root_updates_path is not set."
    end
    super
  end

  # Applies the given update.
  # @param [String|Symbol] update_name
  def apply_update(update_name)
    if TmxDataUpdate.should_run?(update_name)
      get_update_class(TmxDataUpdate.root_updates_path, update_name).new.perform_update
    else
      nil
    end
  end

  # Reverts the given update.
  # @param [String|Symbol] update_name
  def revert_update(update_name)
    if TmxDataUpdate.should_run?(update_name)
      get_update_class(TmxDataUpdate.root_updates_path, update_name).new.undo_update
    else
      nil
    end
  end

end
