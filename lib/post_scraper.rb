require 'nokogiri'
require 'open-uri' # a module not a gem
require_relative './post.rb'

class PostScraper
  def initialize(url)
    @doc = Nokogiri::HTML(open(url))
  end

  def scrape_posts
    posts = @doc.css('.blog_post')

    posts.each do |post|
      this_post = Post.new
      this_post.content = post.text
      this_post.file_name = post.attribute('id')
      puts this_post.file_name
    end
  end

end 


my_blog = PostScraper.new('http://totallynuclear.club/~schlink/')

my_blog.scrape_posts
