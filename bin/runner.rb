#!/usr/bin/env ruby
require_relative '../config/environment'
 
my_newspaper = Newspaper.new
my_newspaper.print

puts "what is your totally nuclear username?"
username = "schlink"

system "scp #{username}@totallynuclear.club:my_newspaper.html ~/Desktop"

# system "lynx my_newspaper.html"
