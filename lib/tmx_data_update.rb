require 'active_support/all' # Should be required first.
require 'tmx_data_update/update_class_loader' #Should be required second.

require 'tmx_data_update/updater'
require 'tmx_data_update/seeds'

# Extends the migrations DSL to include the functionality to execute data updates.
module TmxDataUpdate
  include TmxDataUpdate::UpdateClassLoader

  # Returns the root data updates path.
  def root_updates_path
    raise "Must override in subclass!"
  end

  # Return +true+ if the named update should run, +false+ otherwise.  Subclasses
  # are expected to override this as needed.
  def should_run?(update_name)
    true
  end

  # Applies the given update.
  # @param [String|Symbol] update_name
  def apply_update(update_name)
    if should_run?(update_name)
      get_update_class(root_updates_path, update_name).new.perform_update
    else
      nil
    end
  end

  # Reverts the given update.
  # @param [String|Symbol] update_name
  def revert_update(update_name)
    if should_run?(update_name)
      get_update_class(root_updates_path, update_name).new.undo_update
    else
      nil
    end
  end

end
