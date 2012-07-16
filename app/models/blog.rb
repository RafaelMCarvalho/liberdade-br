class Blog < ActiveRecord::Base
  has_many :posts

  attr_accessible :description, :link, :name, :rss, :posts, :post_ids

  validates_presence_of :name, :link
end
