require 'jeweler'
Jeweler::Tasks.new do |gem|
  gem.name = 'tmx_data_update'
  gem.summary = 'Handle post-release data updates through migrations'
  gem.description = <<-DESC
Allows us to cleanly handle updates to seed data post-launch.
  DESC
  gem.email = 'arthur.shagall@gmail.com'
  gem.homepage = 'http://www.tmxcredit.com'
  gem.authors = ['Arthur Shagall']
  gem.files = Dir["{lib}/**/*"]
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

namespace :gemfury do
  desc "Build version #{gem_version} into the pkg directory and upload to GemFury"
  task :push => [:build] do
    sh "fury push pkg/#{gem_file_name} --as=TMXCredit"
  end
end

require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new do |task|
  task.rspec_opts = ['--color', '--backtrace', '--format nested']
end

