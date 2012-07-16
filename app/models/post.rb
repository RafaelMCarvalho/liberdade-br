class Post < ActiveRecord::Base
  belongs_to :blog

  has_many :author_posts
  has_many :authors, :through => :author_posts
  has_many :category_posts
  has_many :categories, :through => :category_posts

  attr_accessible :title, :published_at, :content, :blog, :authors, :categories,
     :author_ids, :category_ids, :blog_id

  validates_presence_of :title, :content
end
