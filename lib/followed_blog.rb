
class FollowedBlog
  def initialize(url)
    @url = url
    @doc = Nokogiri::HTML(open(url))
  end

  def scrape_posts
    # binding.pry
    if @doc.css('.blog_post').any?
      posts = @doc.css('.blog_post')
    elsif @doc.css('.post').any?
      posts = @doc.css('.post')
    else 
      puts "returning false?"
      return false
    end

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
          if @url.to_s[-1] != '/'
            image.attribute('src').value = @url.to_s + '/../' + image.attribute('src').value
          else
            image.attribute('src').value = @url.to_s + image.attribute('src').value
          end
        end
      end

      # youtube iframes come in with src = to something like '//youtube.com/....'. 
      # If viewing hazmat newspaper on local machine, need to add 'http:' to beginning for it to render
      post.css("iframe").each do |video|
        if video.attribute('src').value && video.attribute('src').value[0..3] != "http"
          video.attribute('src').value = 'http:' + video.attribute('src').value
        end
      end

      this_post.content = post.inner_html

      # replace smart quotes and other puncution with they HTML codes or dumb alternatives
      this_post.content = this_post.content.gsub("“", "&ldquo;").gsub("”", "&rdquo;").gsub("‘", "&lsquo;").gsub("’", "&rsquo;").gsub("–", "&mdash;").gsub('…', '...')
      this_post.content = this_post.content.gsub("&acirc;&#128;&#156;", '&ldquo;').gsub("&acirc;&#128;&#157;", '&rdquo;').gsub("&acirc;&#128;&#152;", "&lsquo;").gsub("&acirc;&#128;&#153;", "&rsquo;")

      # this_post.content = this_post.content[0..1800]

      this_post.base_url = @url.to_s
      this_post.user_name = @url.to_s.partition('~').last.partition('/').first.gsub('/','')

      # do our best to find the file name in the HTML of the post

      if post.attribute('id') && post.attribute('id').value
        this_post.file_name = post.attribute('id').value
      elsif post.css('.date a').any? && post.css('.date a').attribute('name') && post.css('.date a').attribute('name').value
        this_post.file_name = post.css('.date a').attribute('name').value
      else
        puts "Can't find timestamp for this post. So we'll skip it."
        next 
      end

      this_post.perma_url = this_post.base_url + '#' + this_post.file_name

      puts this_post.file_name
      post_objects << this_post
      # puts this_post.user_name
    end

    post_objects
  end

  def compatible?
    if @doc.css('.blog_post').any? || @doc.css('.post').any?
      puts "check_url returned true"
      return true
    else 
      puts "check_url returned false"
      return false
    end
  end
end 

