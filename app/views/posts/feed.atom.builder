atom_feed :language => 'pt-BR' do |feed|
  feed.title @title
  feed.updated @updated

  @posts.each do |post|
    next if post.approved_at.blank?

    feed.entry(post) do |entry|
      entry.url posts_url(post)
      entry.title post.title
      entry.content post.content, :type => 'html'

      # the strftime is needed to work with Google Reader.
      entry.updated(post.approved_at.strftime("%Y-%m-%dT%H:%M:%SZ"))

      post.authors.each do |a|
        entry.author do |author|
          author.name a.name
        end
      end

      post.categories.each do |c|
        entry.category :term => posts_category_url(c.id), :label => c.name
      end
    end
  end
end