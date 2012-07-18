class Blog < ActiveRecord::Base
  has_many :posts

  attr_accessible :description, :link, :name, :rss, :posts, :post_ids

  validates_presence_of :name, :link

  def get_new_posts
    feed = Feedzirra::Feed.fetch_and_parse(self.rss)
    feed.entries.select do |entry|
      if entry.published.strftime('%d/%m/%Y') == Date.today.strftime('%d/%m/%Y')
        Post.create_from_feed(entry)
      end
    end
    #
    # TODO: verify what is the best option. Do it whith .select or all in the .each
    #
    # new_posts = fedd.entries.select do |entry|
    #   entry.published.strftime('%d/%m/%Y') == Date.today.strftime('%d/%m/%Y')
    # end
    #
    # new_posts.each do |post|
    #   Post.create_from_feed(post)
    # end
  end
end
