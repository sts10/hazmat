require 'nokogiri'
require 'open-uri' # a module not a gem
require_relative './post.rb'

class PostScraper
  def initialize(url)
    @url = url
    @doc = Nokogiri::HTML(open(url))
  end

  def scrape_posts
    posts = @doc.css('.blog_post')

    posts.each do |post|
      this_post = Post.new
      this_post.content = post.text
      this_post.file_name = post.attribute('id')
      this_post.user_name = @url.to_s.partition('~').last.gsub('/','')

      puts this_post.file_name
  
      # puts this_post.user_name
    end
  end

end 


my_blog = PostScraper.new('http://totallynuclear.club/~schlink/')

my_blog.scrape_posts
