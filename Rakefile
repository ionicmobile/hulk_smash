require 'rake/clean'
require 'rubygems'
require 'rubygems/package_task'
require "bundler/gem_tasks"

spec = eval(File.read('hulk.gemspec'))

Gem::PackageTask.new(spec) do |pkg|
end
