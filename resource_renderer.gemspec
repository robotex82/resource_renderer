$LOAD_PATH.push File.expand_path('../lib', __FILE__)

# Maintain your gem's version:
require 'resource_renderer/version'

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = 'resource_renderer'
  s.version     = ResourceRenderer::VERSION
  s.authors     = ['Roberto Vasquez Angel']
  s.email       = ['roberto@vasquez-angel.de']
  s.homepage    = 'https://github.com/robotex82/resource_renderer'
  s.summary     = 'A simple way to render resources.'
  s.description = 'A simple way to render resources.'
  s.license     = 'MIT'

  s.files = Dir['{app,config,db,lib}/**/*', 'MIT-LICENSE', 'Rakefile', 'README.rdoc']

  s.add_dependency 'rails', '>= 4.0'

  s.add_development_dependency 'sqlite3'

  s.add_development_dependency 'rubocop'

  s.add_development_dependency 'capybara'
  s.add_development_dependency 'rspec-rails'
  s.add_development_dependency 'shoulda-matchers'
  s.add_development_dependency 'factory_girl_rails'
  s.add_development_dependency 'guard-rails'
  s.add_development_dependency 'guard-bundler'
  s.add_development_dependency 'guard-rspec'
end
