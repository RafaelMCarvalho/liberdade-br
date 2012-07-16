class Category < ActiveRecord::Base
  has_many :category_posts
  has_many :posts, :through => :category_posts

  attr_accessible :name, :posts, :post_ids

  validates_presence_of :name
end
