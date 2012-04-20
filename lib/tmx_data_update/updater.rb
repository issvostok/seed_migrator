module TmxDataUpdate

  # The base class for all post-release data updates
  class Updater

    # Performs the data update.  The subclass must override this method.
    def perform_update
      raise "#{self.class} should override 'update_data'"
    end

    # Reverses the update.  If the update is reversible, this class should
    # be overriden in the subclass.
    def undo_update
      raise "#{self.class} does not support rolling back the update"
    end
  end
end
