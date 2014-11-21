#!/usr/bin/env ruby
require_relative '../config/environment'
 
my_newspaper = Newspaper.new
my_newspaper.print

system "open my_newspaper.html"
