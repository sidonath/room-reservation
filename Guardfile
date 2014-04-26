guard 'rspec', all_after_pass: true, all_on_start: true, keep_failed: true do
  ignore %r|\.swp\Z|

  watch(%r|^spec/(.*)_spec\.rb|)
  watch(%r|^app/(.*)([^/]+)\.rb|)     { |m| "spec/units/#{m[1]}#{m[2]}_spec.rb" }
  watch(%r|^lib/(.*)([^/]+)\.rb|)     { |m| "spec/lib/#{m[1]}#{m[2]}_spec.rb" }
  watch(%r|^spec/spec_helper\.rb|)    { "spec" }
end
