#!/usr/bin/env ruby
require_relative '../config/environment'
 
my_newspaper = Newspaper.new
my_newspaper.print

if File.exist?('~/public_html/hazmat') == false
  system "mkdir ~/public_html/hazmat"
end
system "cp css/styles.css ~/public_html/hazmat/styles.css"
system "cp js/app.js ~/public_html/hazmat/app.js"
system "mv my_newspaper.html ~/public_html/hazmat/my_hazmat_newspaper.html"

puts ""
puts "Your Hazmat newspaper is available at http://totallynuclear.club/~your_username/hazmat/my_hazmat_newspaper.html"
puts ""

puts "Alternatively, you may view your Hazmat newspaper through a console browser called Lynx."
puts "Would you like to open your newspaper here in the console using Lynx? [y/N]"
l_choice = gets.chomp
if l_choice.downcase.strip == 'y'
  system "lynx my_newspaper.html"
end
