require 'jeweler'
Jeweler::Tasks.new do |gem|
  gem.name        = 'seed_migrator'
  gem.summary     = 'Handle post-release data updates through migrations'
  gem.description = "Provides a clean way to handle updates to seed data post-launch."
  gem.email       = ['arthur.shagall@gmail.com', 'zbelzer@gmail.com']
  gem.homepage    = 'https://github.com/HornsAndHooves'
  gem.authors     = ['Arthur Shagall', 'Zach Belzer']
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
  "seed_migrator-#{gem_version}.gem"
end

require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new do |task|
end

task :default => :spec
