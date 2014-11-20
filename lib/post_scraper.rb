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
      this_post.content = post.inner_html

      this_post.content = this_post.content.gsub("“", "&ldquo;").gsub("”", "&rdquo;").gsub("‘", "&lsquo;").gsub("’", "&rsquo;").gsub("–", "&mdash;")  
      this_post.content = this_post.content.gsub("&acirc;&#128;&#156;", '"').gsub("&acirc;&#128;&#153;", "'")

      this_post.base_url = @url.to_s
      this_post.user_name = @url.to_s.partition('~').last.gsub('/','')

      if post.attribute('id') && post.attribute('id').value
        this_post.file_name = post.attribute('id').value
      else
        this_post.file_name = post.css('.date a').attribute('name').value
      end

      this_post.perma_url = this_post.base_url + '#' + this_post.file_name

      puts this_post.file_name
      post_objects << this_post
      # puts this_post.user_name
    end

    post_objects
  end

end 


# my_blog = PostScraper.new('http://totallynuclear.club/~schlink/')

# my_blog.scrape_posts
