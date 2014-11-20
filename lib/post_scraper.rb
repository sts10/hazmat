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
    post_objects =[]

    posts.each do |post|
      this_post = Post.new
      this_post.content = post.text
      this_post.file_name = post.attribute('id').value
      this_post.user_name = @url.to_s.partition('~').last.gsub('/','')

      puts this_post.file_name
      post_objects << this_post
      # puts this_post.user_name
    end

    post_objects
  end

end 


# my_blog = PostScraper.new('http://totallynuclear.club/~schlink/')

# my_blog.scrape_posts
