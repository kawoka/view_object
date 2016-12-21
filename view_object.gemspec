$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "view_object/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "view_object"
  s.version     = ViewObject::VERSION
  s.authors     = ["kawaoka"]
  s.email       = ["br2jn51@yahoo.co.jp"]
  s.homepage    = "http://riveroka.com"
  s.summary     = "ViewObject."
  s.description = "Description of ViewObject."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 4.2.7.1"

  s.add_development_dependency "sqlite3"
end
