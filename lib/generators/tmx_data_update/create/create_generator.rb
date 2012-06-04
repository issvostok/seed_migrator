require 'rails/generators/active_record'
require 'generators/tmx_data_update/helper'

class TmxDataUpdate::CreateGenerator < Rails::Generators::NamedBase
  include Generators::TmxDataUpdate::Helper
  include Rails::Generators::Migration
  extend ActiveRecord::Generators::Migration
  
  source_root File.expand_path('../templates', __FILE__)

  def create_helper_file
    migration_template "data_update.rb", "db/data_updates/#{data_update_file_name}.rb"
    migration_template "data_update_migration.rb", "db/migrate/#{file_name}.rb"
  end
end
