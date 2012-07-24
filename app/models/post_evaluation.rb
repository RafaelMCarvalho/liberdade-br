class PostEvaluation < ActiveRecord::Base
  belongs_to :user
  belongs_to :post

  attr_accessible :user, :post, :user_id, :post_id, :approve
end
