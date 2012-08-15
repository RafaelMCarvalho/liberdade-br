# -*- encoding : utf-8 -*-
class Author < ActiveRecord::Base
  has_many :author_posts
  has_many :posts, :through => :author_posts


  attr_accessible :description, :name, :posts, :post_ids

  validates :name, :presence => true, :uniqueness => true

  def self.get_or_create_by_name(name)
    author = Author.where(:name => name).first
    author ? author : self.create!(:name => name)
  end

  def published_posts
    posts.where("published = ?", true)
  end
end
