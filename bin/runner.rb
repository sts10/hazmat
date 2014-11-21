#!/usr/bin/env ruby
require_relative '../config/environment'
 
current_version = "0.0.4"

my_newspaper = Newspaper.new
my_newspaper.print

system "open my_newspaper.html"
