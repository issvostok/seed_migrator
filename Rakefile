require 'jeweler'
Jeweler::Tasks.new do |gem|
  gem.name        = 'tmx_data_update'
  gem.summary     = 'Handle post-release data updates through migrations'
  gem.description = "Provides a clean way to handle updates to seed data post-launch."
  gem.email       = ['rubygems@tmxcredit.com', 'arthur.shagall@gmail.com', 'zbelzer@gmail.com']
  gem.homepage    = 'http://www.tmxcredit.com'
  gem.authors     = ['TMX Credit', 'Arthur Shagall', 'Zach Belzer']
  gem.files       = Dir["{lib}/**/*"]
end

# Jeweler functions
def read_gem_version
  open('VERSION', 'r'){ |f| f.read }.strip
end

def gem_version
  @gem_version ||= read_gem_version
end

def gem_file_name
  "tmx_data_update-#{gem_version}.gem"
end

require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new do |task|
  task.rspec_opts = ['--color', '--backtrace', '--format nested']
end

task :default => :spec
