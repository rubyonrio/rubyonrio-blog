module PostsHelper
  # This isn't strictly correct, but it's a pretty good guess
  # and saves another hit to the DB
  def more_content?
    @posts.size == Post::DEFAULT_LIMIT
  end

  def disqus_identifier
    slug = @post.old_slug unless @post.old_slug.blank?
    slug ||= post_path(@post)
    output = <<-DISQUS_URL
    <script type="text/javascript">
      var disqus_url = 'http://rubyonrio.org#{slug}'
    </script>
    DISQUS_URL
    output.html_safe unless slug.blank?
  end

  def disqus_developer_mode
    developer_mode = <<-DEVELOPER
    <script text="text/javascript">
      var disqus_developer = 1;
    </script>
    DEVELOPER
    developer_mode.html_safe unless Rails.env == 'production'
  end

  def disqus_comments
    disqus_output = <<-DISQUS_COMMENTS
    <div id='disqus_thread'></div>
      #{disqus_developer_mode}
      #{disqus_identifier}
      <script src='http://disqus.com/forums/rubyonrio/embed.js' type='text/javascript'></script>
      <noscript>
        <a href='http://rubyonrio.disqus.com/?url=ref'>View the discussion thread</a>
      </noscript>
      <a class='dsq-brlink' href='http://disqus.com'>blog comments powered by <span class="logo-disqus">Disqus</span></a>
    </div>
    DISQUS_COMMENTS
    disqus_output.html_safe
  end
end
