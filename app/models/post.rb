class Post < ActiveRecord::Base
  belongs_to :blog

  has_many :author_posts
  has_many :authors, :through => :author_posts
  has_many :category_posts
  has_many :categories, :through => :category_posts
  has_many :post_evaluations
  has_many :users, :through => :post_evaluations, :dependent => :destroy

  attr_accessible :title, :url, :content, :published_at, :blog, :authors,
     :author_ids, :categories,:category_ids, :blog_id,
     :evaluations, :evaluation_ids, :post_evaluations, :post_evaluation_ids

  validates_presence_of :title, :content

  def self.create_from_feed_entry(entry)
    categories = []
    entry.categories.each do |name|
      categories << Category.get_or_create_by_name(name)
    end

    authors = []
    entry.author.split(',').each do |name|
      authors << Author.get_or_create_by_name(name.strip)
    end

    Post.create(
      :title => entry.title,
      :url => entry.url,
      :content => entry.content,
      :published_at => entry.published,
      :categories => categories,
      :authors => authors
    )
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
