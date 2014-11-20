require 'nokogiri'
require 'open-uri' # a module not a gem

class PostScraper
  def initialize(url)
    @doc = Nokogiri::HTML(open(url))
  end

  def scrape_posts
    posts = @doc.css('.blog_post')

    posts.each do |post|
      puts post.text
    end
  end

end 


my_blog = PostScraper.new('http://totallynuclear.club/~schlink/')

my_blog.scrape_posts
