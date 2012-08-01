guard 'rspec', :version => 2, spec_paths: ["spec/lib"] do
  watch(%r{^spec/lib/hulk/.+_spec\.rb$})
 watch(%r{^lib/hulk/(.+)\.rb})                            { |m| "spec/lib/hulk/#{m[1]}_spec.rb" }
end
