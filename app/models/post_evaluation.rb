# -*- encoding : utf-8 -*-
class PostEvaluation < ActiveRecord::Base
  belongs_to :user
  belongs_to :post

  attr_accessible :user, :post, :user_id, :post_id, :approve

  after_save :call_to_update_evaluation_rates

  def call_to_update_evaluation_rates
    Post.find(self.post_id).update_evaluation_rates
  end
end
