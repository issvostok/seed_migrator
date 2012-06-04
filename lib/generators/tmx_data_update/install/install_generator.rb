require 'generators/tmx_data_update/helper'

class TmxDataUpdate::InstallGenerator < Rails::Generators::Base
  include Generators::TmxDataUpdate::Helper

  source_root File.expand_path('../templates', __FILE__)

  # Create the initializer file with default options.
  def create_initializer
    if File.directory? "lib/#{application_name}"
      log :initializer, "Assuming Engine. Adding custom data update module"
      template "data_update_module.rb", "lib/#{application_name}/#{application_name}_data_update.rb"
    end
  end

  def update_seeds
    log :initializer, "Adding data update seeder to seeds.rb"

    seed_code =<<SEED
include TmxDataUpdate::Seeds
apply_updates Rails.root.join('db', 'data_updates')
SEED

    in_root do
      inject_into_file 'db/seeds.rb', "\n#{seed_code}\n", { :before => /\z/, :verbose => false }
    end
  end
end
