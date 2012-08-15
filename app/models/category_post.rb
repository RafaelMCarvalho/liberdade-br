# -*- encoding : utf-8 -*-
class CategoryPost < ActiveRecord::Base
  belongs_to :category
  belongs_to :post

  attr_accessible :category, :post, :category_id, :post_id
end
