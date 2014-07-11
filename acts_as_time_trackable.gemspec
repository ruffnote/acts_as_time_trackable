$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "acts_as_time_trackable/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "acts_as_time_trackable"
  s.version     = ActsAsTimeTrackable::VERSION
  s.authors     = ["Ruffnote Inc."]
  s.email       = ["info@ruffnote.com"]
  s.homepage    = "https://github.com/ruffnote/acts_as_time_trackable"
  s.summary     = "Time tracking your model"
  s.description = s.summary
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", ">= 4.0.0"
  s.add_dependency "ruby-duration", "~> 3.1.0"

  s.add_development_dependency "sqlite3"
  s.add_development_dependency "simplecov"
end
