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

  def approval_rate
    evaluations = self.post_evaluations
    approvals = evaluations.select { |e| e.approve }
    if evaluations.count.zero?
      return 0
    else
      return approvals.count/evaluations.count
    end
  end

  def reproval_rate
  end

  def evaluations_count
    self.post_evaluations.count
  end
end
