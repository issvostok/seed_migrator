require 'rails/generators/active_record'
require 'generators/seed_migrator/helper'

# Generator to create a data update + associated migration
class SeedMigrator::CreateGenerator < Rails::Generators::NamedBase
  include Generators::SeedMigrator::Helper
  include Rails::Generators::Migration
  extend ActiveRecord::Generators::Migration
  
  source_root File.expand_path('../templates', __FILE__)

  # Creates the data update file and the migration file.
  def create_helper_file
    migration_template "data_update.rb", "db/data_updates/#{file_name}_data_update.rb"
    migration_template "data_update_migration.rb", "db/migrate/#{file_name}.rb"
  end
end
