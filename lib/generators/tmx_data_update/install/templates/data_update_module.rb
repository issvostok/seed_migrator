# Facilitates conducting data migrations.
module <%= application_class_name %>DataUpdate
  include TmxDataUpdate

  # Returns the path where data updates are
  def root_updates_path
    <%= application_class_name %>::Engine.root.join('db','data_updates')
  end

  # Updates will run in production, but not in test an dev.
  def should_run?(_)
    Rails.env.production?
  end

end
