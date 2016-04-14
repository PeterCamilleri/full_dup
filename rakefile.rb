require 'rake/testtask'
require "bundler/gem_tasks"

#Run the unit test suite.
Rake::TestTask.new do |t|
  #List out all the test files.
  t.test_files = ["test/full_dup_tests.rb",
                  "test/object_tests.rb",
                  "test/array_tests.rb",
                  "test/hash_tests.rb",
                  "test/struct_tests.rb"]

  t.verbose = false
  t.warning = true
end

desc "What version of full_dup is this?"
task :vers do |t|
  puts
  puts "full_dup version = #{FullDup::VERSION}"
end

