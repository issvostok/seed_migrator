module TmxDataUpdate
  module UpdateClassLoader

    # Loads the class corresponding to the given update name from the given
    # file system path.
    # @param [String|Pathname|Symbol] root_path
    # @param [String|Symbol] update_name
    # @return [::Class]
    def get_update_class(root_path, update_name)
      if root_path.ends_with?('/')
        require "#{root_path}#{update_name}"
      else
        require "#{root_path}/#{update_name}"
      end
      update = strip_seq_prefix(update_name.to_s)
      update.camelize.constantize
    end

    def strip_seq_prefix(update_name)
      index = update_name =~ /_/
      if index
        start = update_name[0,1]
        # If the first letter of the prefix is a digit, we assume the prefix is
        # for sequence ordering purposes.
        if ['1', '2', '3', '4', '5', '6', '7', '8', '9', '0'].include?(start)
          update_name = update_name[index + 1, update_name.size - index]
        end
      end
      update_name
    end
    private :strip_seq_prefix
  end
end