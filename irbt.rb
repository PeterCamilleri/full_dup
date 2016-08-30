# coding: utf-8
# An IRB + full_dup test bed

require 'irb'

puts "Starting an IRB console with full_dup loaded."

if ARGV[0] == 'local'
  require_relative 'lib/full_dup'
  puts "full_dup loaded locally: #{FullDup::VERSION}"

  ARGV.shift
else
  require 'full_dup'
  puts "full_dup loaded from gem: #{FullDup::VERSION}"
end

IRB.start
