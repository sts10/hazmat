#!/usr/bin/env ruby
require_relative '../config/environment'

has_function = open('~/.bash_profile').grep(/function hazmat/)
if has_function != []
  puts "It look like you already have a hazmat function in your bash_profile. Cool."
else
  puts "It looks like you don't have a hazmat function in your bash_profile"
  puts "I'm about to edit your .bash_profile in order to make Hazmat easier to run."
  puts "Once the function is inserted you'll be able to run Hazmat by just typing hazmat and pressing enter anywhere in your box."
  puts "If you have already done this, or you have your own method of callind hazmat,"
  puts "don't run this."
  puts ""
  puts "Add a hazmat function to your .bash_profile? (y/N)"

  b_choice = gets.chomp.strip.downcase

  if b_choice == 'y'
    puts "Adding a hazmat function to your .bash_profile."
    File.open('~/.bash_profile', "a") do |f|
      f.puts("")
      f.puts("# This function lets you call Hazmat from anywhere in your box by")
      f.puts("# simply typing hazmat and pressing enter.")
      f.puts("function hazmat {")
      f.puts("    cwd=$(pwd)")
      f.puts("    cd ~/hazmat")
      f.puts("    ruby bin/runner.rb $1")
      f.puts("    cd $cwd")
      f.puts("}")
      f.puts("")
      # f.close
  end

  system "source ~/.bash_profile"

  system "clear"
  puts "Cool. You should be good to go."
  puts "Now, whenever you want to run Hazmat, just type hazmat and press enter."
  puts "To edit the list of Radiation blogs you follow, run hazmat following"
  puts ""
  puts "If you'd like to check your .bash_profile for youself, quit Hazmat"
  puts "and run vim ~/.bash_profile"
  puts ""
  puts "Press ENTER to continue..."
  gets
end


ARGV[0].to_s = command
command = command.downcase.strip

if command == "following"
  system "vim following.rb"
  puts "Running Hazmat now with new following list"
elsif command.gsub("-", "") == "help" || command == "-h"
  puts "Running Hazmat will print your Hazmat newspaper."
  puts "To edit the list of Radiation blogs you follow, run hazmat following"
end

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
  system "lynx ~/public_html/hazmat/my_hazmat_newspaper.html"
end
