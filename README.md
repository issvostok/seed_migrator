# TMX Data Update

The problem of seed data can get annoying once your Rails app is in production.
Ordinarily, you would place your seeds data in `seeds.rb`.  Unfortunately, once
your application goes live, you will likely not be in a position to reload your
seeds.  This leaves you with Rails migrations as the likely choice, but
that now makes development harder, because things seed out of order (migrations
run before seeds).  This gem solves these problems.

## Installation

In your Gemfile:

    gem 'tmx_data_update'

## Deploying to GemFury

Make sure you have an account on GemFury and it has been made a collaborator of the TMXCredit corporate account, then run:

    rake gemfury:push

## Usage

Data updates are defined similar to migrations.  Each file contains a class
definition which should ideally extend `TmxDataUpdate::Updater` but doesn't have
to as long as it implements `apply_update` and `revert_update`.   They need to
follow the default Rails naming convention; a file called
`update_order_types.rb` should contain the class `UpdateOrderTypes`.  It is
highly recommended that each file have a prefix that defines its order.  The
format is pretty flexible, but the prefix must start with a number and not have
any underscores.  So `01_update_order_types.rb` is fine, so is
`1A5_update_order_types.rb`.  In each of these cases, the name of the class is
still `UpdateOrderTypes`.If you extend `TmxDataUpdate::Updater` you only need to
override `revert_update` if you need your migration to be reversible, otherwise
it's not necessary.

Here's an example data update class definition:

    class UpdateOrderTypes < TmxDataUpdates::Updater
      def perform_update
        OrderType.create :type_code => 'very_shiny'
      end

      # Overriden in case we need to roll back this migration.
      def undo_update
        OrderType.where(:type_code => 'very_shiny').first.delete
      end
    end

### Migrations

Assuming we have created the update file above in `db/data_updates` in a
file named `01_update_order_types.rb`

`root_updates_path` and  optionally `should_run?(update_name)` must be defined
in every migration where we intend to do data updates.  Realistically, our app
should extend `TmxDataUpdate` and then include the new module in each migration
where needed.

    module CoreDataUpdate
      include TmxDataUpdate

      def root_updates_path
        Rails.root.join('db','data_updates')
      end

      def should_run?(update_name)
        Rails.env == 'production'
      end
    end

Now, define a migration that will perform our data update.

    class CreateVeryShinyOrderType < ActiveRecord::Migration
      include CoreDataUpdate

      def up
        apply_update :01_update_order_types
      end

      def down
        revert_update :01_update_order_types
      end
    end

Old style migrations, i.e. `def self.up` are not supported.

### Seeds

At the bottom of your `seeds.rb`, include the following:

    include TmxDataUpdate::Seeds
    apply_updates Rails.root.join('db','data_updates')

## Testing

Install all the gem dependencies.

    bundle install

Run tests

    rake spec

## License

Copyright (c) 2012 TMX Credit.
May not be used or distributed without the express written consent of TMX Credit.
