require_relative "lib/librails/version"

Gem::Specification.new do |spec|
  spec.name        = "librails"
  spec.version     = Librails::VERSION
  spec.authors     = ["src256"]
  spec.email       = ["src@srcw.net"]
  spec.homepage    = "https://github.com/src256/librails"
  spec.summary     = "My Rails Plugin"
  spec.description = "My Rails Plugin"
  spec.license     = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the "allowed_push_host"
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  # spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage
  spec.metadata["changelog_uri"] = spec.homepage

  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]
  end

  spec.add_dependency "rails", ">= 7.0.8"
  spec.add_development_dependency "mysql2", "~> 0.5"
end
