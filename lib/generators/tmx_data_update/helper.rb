module Generators
  module TmxDataUpdate
    module Helper
      def application_name
        if defined?(Rails) && Rails.application
          Rails.application.class.name.split('::').first.underscore
        else
          "application"
        end
      end

      def application_class_name
        application_name.classify
      end

      def data_update_class_name
        migration_class_name
      end

      def data_update_file_name
        "#{file_name}_data_update"
      end
    end
  end
end
