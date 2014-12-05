#!/usr/bin/env ruby
require_relative '../config/environment'
 
my_newspaper = Newspaper.new
my_newspaper.print

puts "what is your totally nuclear username?"
username = "schlink"

system "mkdir ~/public_html/hazmat"
system "cp css/styles.css ~/public_html/hazmat/styles.css"
system "cp js/app.js ~/public_html/hazmat/app.js"
system "mv my_newspaper.html ~/public_html/hazmat/my_hazmat_newspaper.html"

# system "lynx my_newspaper.html"
