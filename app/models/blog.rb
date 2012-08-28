# -*- encoding : utf-8 -*-
class Blog < ActiveRecord::Base
  has_many :posts, :dependent => :destroy

  has_attached_file :image,
    :path => ":rails_root/public/system/blogs/:id/:style/:filename",
    :url => "/system/blogs/:id/:style/:filename",
    :styles => {
      :small => '250x100#', :thumb => '125x50#'
    }

  validates_attachment_content_type :image,
    :content_type => /^image\/(jpg|jpeg|pjpeg|png|x-png|gif)$/,
    :message => 'com formato inválido'

  attr_accessible :description, :link, :name, :rss, :posts, :post_ids, :image
  attr_accessor :delete_image

  before_validation { self.image.clear if self.delete_image == '1' }

  validates_presence_of :name, :link, :rss

  before_validation :add_protocol_to_links

  validates_format_of :link, :rss, :allow_blank => true, :with => /^(?:(?:https?|ftp|git):\/\/)?(?:\S+(?::\S*)?@)?(?:(?!10(?:\.\d{1,3}){3})(?!127(?:\.\d{1,3}){3})(?!169\.254(?:\.\d{1,3}){2})(?!192\.168(?:\.\d{1,3}){2})(?!172\.(?:1[6-9]|2\d|3[0-1])(?:\.\d{1,3}){2})(?:[1-9]\d?|1\d\d|2[01]\d|22[0-3])(?:\.(?:1?\d{1,2}|2[0-4]\d|25[0-5])){2}(?:\.(?:[1-9]\d?|1\d\d|2[0-4]\d|25[0-4]))|(?:(?:[a-z\u00a1-\uffff0-9]+-?)*[a-z\u00a1-\uffff0-9]+)(?:\.(?:[a-z\u00a1-\uffff0-9]+-?)*[a-z\u00a1-\uffff0-9]+)*(?:\.(?:[a-z\u00a1-\uffff]{2,})))(?::\d{2,5})?(?:\/[^\s]*)?$/i

  def published_posts
    posts.where('published = ? and criterion_for_publication <> ? or criterion_for_publication = ?',
      true, Post::CRITERION_FOR_PUBLICATION[:always_unpublished], Post::CRITERION_FOR_PUBLICATION[:always_published])
  end

  def add_protocol_to_links
    unless self.link.blank?
      self.link = 'http://' + self.link if self.link.match(/^(\w*):\/\//i).nil?
    end
    unless self.rss.blank?
      self.rss = 'http://' + self.rss if self.rss.match(/^(\w*):\/\//i).nil?
    end
  end

  def self.get_new_posts
    date = Date.today.strftime('%d/%m/%Y')
    all.each do |blog|
      feed = Feedzirra::Feed.fetch_and_parse(blog.rss)
      feed.entries.select do |entry|
        if entry.published.strftime('%d/%m/%Y') == date
          Post.create_from_feed_entry(entry, blog)
        end
      end
    end
  end
end