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
bin/hulk
lib/hulk/version.rb
lib/hulk.rb
  )
  s.require_paths << 'lib'
  s.bindir = 'bin'
  s.executables << 'hulk'
  s.add_development_dependency('rake')
  s.add_development_dependency('rspec')
  s.add_development_dependency('guard-rspec')
  s.add_runtime_dependency('gli','2.0.0.rc6')
end
