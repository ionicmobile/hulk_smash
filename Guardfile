guard 'rspec', :version => 2, spec_paths: ["spec/lib"] do
  watch(%r{^spec/lib/hulk_smash/.+_spec\.rb$})
 watch(%r{^lib/hulk_smash/(.+)\.rb})                            { |m| "spec/lib/hulk_smash/#{m[1]}_spec.rb" }
end
