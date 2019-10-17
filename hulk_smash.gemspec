# Ensure we require the local version and not one we might have installed already
require File.join([File.dirname(__FILE__),'lib','hulk_smash','version.rb'])
spec = Gem::Specification.new do |s| 
  s.name = 'hulk_smash'
  s.version = HulkSmash.version
  s.author = 'Matt Simpson'
  s.email = 'matt.simpson@asolutions.com'
  s.homepage = 'http://asynchrony.com'
  s.platform = Gem::Platform::RUBY
  s.summary = 'Hulking is the act of testing the scalability of your app'
# Add your other files here if you make them
  s.files = %w(
lib/hulk_smash.rb
lib/hulk_smash/version.rb
lib/hulk_smash/smasher.rb
lib/hulk_smash/result.rb
lib/hulk_smash/validator.rb
lib/hulk_smash/request.rb
lib/hulk_smash/url_data_converter.rb
  )
  s.require_paths << 'lib'
  s.add_development_dependency('rake', "~> 0.9.2")
  s.add_development_dependency('rspec', "~> 2.8.0")
  s.add_development_dependency "yard", "~> 0.9.20"
  s.add_development_dependency('guard-rspec', "~> 0.6.0")
end
