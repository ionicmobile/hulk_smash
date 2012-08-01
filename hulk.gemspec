# Ensure we require the local version and not one we might have installed already
require File.join([File.dirname(__FILE__),'lib','hulk','version.rb'])
spec = Gem::Specification.new do |s| 
  s.name = 'hulk'
  s.version = Hulk.version
  s.author = 'Matt Simpson'
  s.email = 'matt.simpson@asolutions.com'
  s.homepage = 'http://asynchrony.com'
  s.platform = Gem::Platform::RUBY
  s.summary = 'Hulking is the act of testing the scalability of your app'
# Add your other files here if you make them
  s.files = %w(
lib/hulk/version.rb
lib/hulk.rb
lib/hulk/smasher.rb
lib/hulk/result.rb
lib/hulk/validator.rb
log/.gitkeep
  )
  s.require_paths << 'lib'
  s.add_development_dependency('rake', "~> 0.9.2")
  s.add_development_dependency('rspec', "~> 2.8.0")
  s.add_development_dependency "yard", "~> 0.7.5"
  s.add_development_dependency('guard-rspec', "~> 0.6.0")
end
