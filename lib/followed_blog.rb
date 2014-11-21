
class FollowedBlog
  def initialize(url)
    @url = url
    @doc = Nokogiri::HTML(open(url))
  end

  def scrape_posts
    posts = @doc.css('.blog_post')
    post_objects =[]

    posts.each do |post|
      this_post = Post.new

      # Convert relative paths from links and images to absolute paths
      # Note: I still need to figure out how to get these to AVOID 
      # relative paths in <code> blocks! 

      post.css("a").each do |link|
        if link.attribute('href').value && link.attribute('href').value[0..3] != "http"
          link.attribute('href').value = @url.to_s + link.attribute('href').value
        end
      end

      post.css("img").each do |image|
        if image.attribute('src').value && image.attribute('src').value[0..3] != "http"
          image.attribute('src').value = @url.to_s + image.attribute('src').value
        end
      end

      this_post.content = post.inner_html

      this_post.content = this_post.content.gsub("“", "&ldquo;").gsub("”", "&rdquo;").gsub("‘", "&lsquo;").gsub("’", "&rsquo;").gsub("–", "&mdash;")  
      this_post.content = this_post.content.gsub("&acirc;&#128;&#156;", '&ldquo;').gsub("&acirc;&#128;&#157;", '&rdquo;').gsub("&acirc;&#128;&#152;", "&lsquo;").gsub("&acirc;&#128;&#153;", "&rsquo;")

      # this_post.content = this_post.content[0..1800]

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

