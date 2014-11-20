require 'nokogiri'
require 'open-uri' # a module not a gem
require 'erb'
require 'date'
require 'tzinfo'
require 'pry'

require_relative './post.rb'
require_relative './post_scraper.rb'
require_relative '../following.rb'

class Newspaper
  def print
    @posts_array = []

    $following.each do |followed_url|
      this_blog = PostScraper.new(followed_url)
      @posts_array = @posts_array + this_blog.scrape_posts
    end
    @posts_array.flatten
    
    # this is untested!!!
    @posts_array.sort_by! { |post| post.file_name }.reverse!

    puts "Printing your newspaper..."

    @posts_array.each do |post| 
      puts post.file_name 
      # binding.pry
    end

    template_doc= File.open('../templates/newspaper.html.erb', "r")

    template = ERB.new(template_doc.read)
    
    File.open('../my_newspaper.html', "w") do |f|
        f.write(
          template.result(binding) # result is an ERB method. `binding` here means we're passing all local variables to the template. 
        )
      f.close
    end
  end

end

my_newspaper = Newspaper.new
my_newspaper.print