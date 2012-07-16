class Author < ActiveRecord::Base
  has_many :author_posts
  has_many :posts, :through => :author_posts

  attr_accessible :description, :name, :posts, :post_ids

  validates_presence_of :name
end
