$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "view_object/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|

  s.name        = "view_object"
  s.version     = ViewObject::VERSION
  s.authors     = ["kawaoka"]
  s.email       = ["br2jn51@yahoo.co.jp"]
  s.homepage    = "https://github.com/kawoka/view_object"
  s.summary     = "ViewObject."
  s.description = "Description of ViewObject."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency 'activesupport', '>= 3.0.0'
  s.add_dependency 'actionpack', '>= 3.0.0'
  s.add_development_dependency 'bundler', '>= 1.0.0'
  s.add_development_dependency 'rake', '>= 0'
  s.add_development_dependency 'tzinfo', '>= 0'
  s.add_development_dependency 'rspec', '>= 0'
  s.add_development_dependency 'rspec-rails', '>= 0'
  s.add_development_dependency 'rails', '= 4.2.11'
  s.add_development_dependency 'sqlite3', '~> 1.3.6'
  s.add_development_dependency 'pry-rails', '>= 0'
end
