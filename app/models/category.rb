# -*- encoding : utf-8 -*-
class Category < ActiveRecord::Base
  has_many :category_posts
  has_many :posts, :through => :category_posts

  attr_accessible :name, :posts, :post_ids

  validates :name, :presence => true, :uniqueness => true

  before_save :downcase_name

  def self.get_or_create_by_name(name)
    category = Category.where(:name => name).first
    category ? category : self.create(:name => name)
  end

  def published_posts
    posts.where("published = ?", true)
  end

  private
  def downcase_name
    self.name = name.downcase_with_accents
  end
end