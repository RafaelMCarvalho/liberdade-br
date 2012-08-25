# -*- encoding : utf-8 -*-
class Post < ActiveRecord::Base
  belongs_to :blog

  has_many :author_posts
  has_many :authors, :through => :author_posts
  has_many :category_posts
  has_many :categories, :through => :category_posts
  has_many :post_evaluations, :dependent => :destroy
  has_many :users, :through => :post_evaluations

  validates_presence_of :title
  validates_presence_of :authors, :if => lambda { self.blog.nil? }
  validates_presence_of :content, :if => lambda { self.blog.nil? }

  after_validation :check_rates_to_publish, :if => lambda {
    self.approval_rate_changed? or self.reproval_rate_changed?
  }

  attr_accessible :title, :url, :content, :published_at, :blog, :authors,
     :author_ids, :categories,:category_ids, :blog_id,
     :evaluations, :evaluation_ids, :post_evaluations, :post_evaluation_ids,
     :approval_rate, :reproval_rate, :hilight, :both_rates

  def self.create_from_feed_entry(entry, blog)
    categories = []
    entry.categories.each do |name|
      categories << Category.get_or_create_by_name(name)
    end

    authors = []
    entry.author.split(',').each do |name|
      authors << Author.get_or_create_by_name(name.strip)
    end

    Post.create!(
      :title => entry.title,
      :url => entry.url,
      :content => entry.content,
      :published_at => entry.published,
      :categories => categories,
      :authors => authors,
      :blog => blog
    )
  end

  def self.build_from_new_post_page(params)
    categories = []
    unless params[:categories].nil?
      params[:categories].split(',').each do |name|
        categories << Category.get_or_create_by_name(name.strip)
      end
    end

    authors = []
    unless params[:authors].nil?
      params[:authors].split(',').each do |name|
        authors << Author.get_or_create_by_name(name.strip)
      end
    end

    post = Post.new(
      :title => params[:title],
      :content => params[:content],
      :categories => categories,
      :authors => authors
    )
    return post
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

  def evaluations_pretty
  end
end
