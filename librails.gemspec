$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "librails/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "librails"
  s.version     = Librails::VERSION
  s.authors     = ["src"]
  s.email       = ["src@srcw.net"]
  s.homepage    = ""
  s.summary     = "My Rails Plugin"
  s.description = "My Rails Plugin"
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 4.2.6"

  s.add_development_dependency "sqlite3"
end
