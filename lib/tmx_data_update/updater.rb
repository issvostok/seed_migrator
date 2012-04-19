module TmxDataUpdate
  class Updater
    def perform_update
      raise "#{self.class} should override 'update_data'"
    end

    def undo_update
      raise "#{self.class} does not support rolling back the update"
    end
  end
end
