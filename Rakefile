require "bundler/gem_tasks"
require 'rake/testtask'

Rake::TestTask.new do |test|
  test.name = 'spec'
  test.pattern = 'test/spec/**/*_spec.rb'
  test.verbose = true
end


Rake::TestTask.new do |t|
  t.name = 'test'
  t.pattern = 'test/integration/test_*.rb'
  t.verbose = true
end

task :wipe do
  system "rm -r test/spec/cassettes/"
end