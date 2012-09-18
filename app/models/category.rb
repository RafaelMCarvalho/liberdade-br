# -*- encoding : utf-8 -*-
class Category < ActiveRecord::Base
  has_many :category_posts
  has_many :posts, :through => :category_posts
  belongs_to :configuration

  attr_accessible :name, :posts, :post_ids, :configuration_id, :configuration

  validates :name, :presence => true, :uniqueness => true

  before_save :downcase_name

  def self.get_or_create_by_name(name)
    category = Category.where(:name => name).first
    category ? category : self.create(:name => name)
  end

  def published_posts
    posts.where('published = ? and criterion_for_publication <> ? or criterion_for_publication = ?',
      true, Post::CRITERION_FOR_PUBLICATION[:always_unpublished], Post::CRITERION_FOR_PUBLICATION[:always_published])
  end

  private
  def downcase_name
    self.name = name.downcase_with_accents
  end
end