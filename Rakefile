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

require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new do |task|
  task.rspec_opts = ['--color', '--backtrace', '--format nested']
end

