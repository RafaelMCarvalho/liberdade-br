class Category < ActiveRecord::Base
  has_many :category_posts
  has_many :posts, :through => :category_posts

  attr_accessible :name, :posts, :post_ids

  validates :name, :presence => true, :uniqueness => true

  before_save :downcase_name

  private
  def downcase_name
    self.name = name.downcase
  end
end
