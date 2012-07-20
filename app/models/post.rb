class Post < ActiveRecord::Base
  belongs_to :blog

  has_many :author_posts
  has_many :authors, :through => :author_posts
  has_many :category_posts
  has_many :categories, :through => :category_posts
  has_many :post_evaluations
  has_many :users, :through => :post_evaluations, :dependent => :destroy

  attr_accessible :title, :published_at, :content, :blog, :authors, :categories,
     :author_ids, :category_ids, :blog_id, :evaluations, :evaluation_ids,
     :post_evaluations, :post_evaluation_ids

  validates_presence_of :title, :content

  def self.create_from_feed(entry)
  end
end
