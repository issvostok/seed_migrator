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
    perform(update_name, :apply)
  end

  # Reverts the given update.
  # @param [String|Symbol] update_name
  def revert_update(update_name)
    perform(update_name, :revert)
  end

  # Performs the update action
  # @param [String] update_name
  # @param [Symbol] action Update action.  Either :apply or :revert
  def perform(update_name, action)
    update = load_updater_class(update_name)

    if should_run?(update_name)
      if action == :apply
        update.perform_update
      elsif action == :revert
        update.undo_update
      end
    end
  end
  private :perform

  # Loads the updater class and instantiates it.
  # @param [String] update_name
  def load_updater_class(update_name)
    get_update_class(root_updates_path, update_name).new
  end
  private :load_updater_class

end
