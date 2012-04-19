require 'tmx_data_update/updater'
require 'active_support/all'

module TmxDataUpdate
  def self.root_updates_path=(path)
    @root_path = path
  end

  def self.root_updates_path
    @root_path
  end

  def self.included(base)
    if root_updates_path.nil?
      puts "Warning: TmxDataUpdate#root_updates_path is not set."
    end
    super
  end

  def apply_update(update_name)
    get_update_class(update_name).new.perform_update
  end

  def revert_update(update_name)
    get_update_class(update_name).new.undo_update
  end

  def get_update_class(update_name)
    path = TmxDataUpdate.root_updates_path
    if path.ends_with?('/')
      require "#{path}#{update_name}"
    else
      require "#{path}/#{update_name}"
    end
    update_name.to_s.camelize.constantize
  end
  private :get_update_class
end
