require 'active_support/all' # Should be required first.
require 'tmx_data_update/update_class_loader' #Should be required second.

require 'tmx_data_update/updater'
require 'tmx_data_update/seeds'

# Extends the migrations DSL to include the functionality to execute data updates.
#
# Note that each data update class is instantiated regardless of whether it is
# expected to run. This enables the developer to discover any data update that
# is incorrectly referenced in a migration, prior to deployment to production.
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
    perform(update_name, :perform_update)
  end

  # Reverts the given update.
  # @param [String|Symbol] update_name
  def revert_update(update_name)
    perform(update_name, :undo_update)
  end

  # Perform the update action.
  # @param [String] update_name
  # @param [Symbol] action Update action.
  #         Either :perform_update or :undo_update
  def perform(update_name, action)
    update = load_updater_class(update_name)

    update.send(action) if should_run?(update_name)
  end
  private :perform

  # Load the updater class and instantiate it. This enables the developer
  # to discover when the data update has been incorrectly referenced in the
  # migration, prior to deployment to production.
  # @param [String] update_name
  def load_updater_class(update_name)
    get_update_class(root_updates_path, update_name).new
  end
  private :load_updater_class

end
