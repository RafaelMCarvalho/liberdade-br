class Blog < ActiveRecord::Base
  has_many :posts, :dependent => :destroy

  attr_accessible :description, :link, :name, :rss, :posts, :post_ids

  validates_presence_of :name, :link

  before_validation :add_protocol_to_link

  validates_format_of :link, :allow_blank => true, :with => /^(?:(?:https?|ftp|git):\/\/)?(?:\S+(?::\S*)?@)?(?:(?!10(?:\.\d{1,3}){3})(?!127(?:\.\d{1,3}){3})(?!169\.254(?:\.\d{1,3}){2})(?!192\.168(?:\.\d{1,3}){2})(?!172\.(?:1[6-9]|2\d|3[0-1])(?:\.\d{1,3}){2})(?:[1-9]\d?|1\d\d|2[01]\d|22[0-3])(?:\.(?:1?\d{1,2}|2[0-4]\d|25[0-5])){2}(?:\.(?:[1-9]\d?|1\d\d|2[0-4]\d|25[0-4]))|(?:(?:[a-z\u00a1-\uffff0-9]+-?)*[a-z\u00a1-\uffff0-9]+)(?:\.(?:[a-z\u00a1-\uffff0-9]+-?)*[a-z\u00a1-\uffff0-9]+)*(?:\.(?:[a-z\u00a1-\uffff]{2,})))(?::\d{2,5})?(?:\/[^\s]*)?$/i

  def add_protocol_to_link
    unless self.link.blank?
      self.link = 'http://' + self.link if self.link.match(/^(\w*):\/\//i).nil?
    end
  end

  def get_new_posts
    feed = Feedzirra::Feed.fetch_and_parse(self.rss)
    feed.entries.select do |entry|
      if entry.published.strftime('%d/%m/%Y') == Date.today.strftime('%d/%m/%Y')
        Post.create_from_feed_entry(entry)
      end
    end
  end
end
