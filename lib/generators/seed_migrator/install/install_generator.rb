require 'generators/seed_migrator/helper'

# Generator to install tmx data update in a new rails system.
class SeedMigrator::InstallGenerator < Rails::Generators::Base
  include Generators::SeedMigrator::Helper

  source_root File.expand_path('../templates', __FILE__)

  # Create the initializer file with default options.
  def create_initializer
    log :initializer, "Adding custom data update module"

    if application?
      template "data_update_module.rb", "config/initializers/#{application_name}_data_update.rb"
    else
      template "data_update_module.rb", "lib/#{application_name}/#{application_name}_data_update.rb"
    end
  end

  # Update seeds.rb
  def update_seeds
    log :initializer, "Adding data update seeder to seeds.rb"

    seed_code =<<SEED
include SeedMigrator::Seeds
apply_updates #{full_application_class_name}.root.join('db', 'data_updates')
SEED

    in_root do
      inject_into_file 'db/seeds.rb', "\n#{seed_code}\n", { :before => /\z/, :verbose => false }
    end
  end
end
