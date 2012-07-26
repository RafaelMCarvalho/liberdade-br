class Post < ActiveRecord::Base
  belongs_to :blog

  has_many :author_posts
  has_many :authors, :through => :author_posts
  has_many :category_posts
  has_many :categories, :through => :category_posts
  has_many :post_evaluations, :dependent => :destroy
  has_many :users, :through => :post_evaluations

  attr_accessible :title, :published_at, :content, :blog, :authors, :categories,
     :author_ids, :category_ids, :blog_id, :evaluations, :evaluation_ids,
     :post_evaluations, :post_evaluation_ids, :approval_rate, :reproval_rate

  validates_presence_of :title, :content

  after_validation :check_rates_to_publish, :if => lambda {
    self.approval_rate_changed? or self.reproval_rate_changed?
  }

  def self.create_from_feed(entry)
  end

  def evaluations_count
    self.post_evaluations.count
  end

  def check_rates_to_publish
    if self.reproval_rate >= 50.0
      self.published = false
    elsif self.approval_rate >= 20.0
      self.published = true
    end
  end

  def update_evaluation_rates
    approvals = self.post_evaluations.where('approve = ?', true).count
    reprovals = self.post_evaluations.where('approve = ?', false).count
    users = User.count
    self.update_attributes(
      :approval_rate => (approvals.to_f/users.to_f*100).round(1),
      :reproval_rate => (reprovals.to_f/users.to_f*100).round(1)
    )
  end
end
