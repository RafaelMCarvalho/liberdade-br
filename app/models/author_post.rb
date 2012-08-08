# -*- encoding : utf-8 -*-
class AuthorPost < ActiveRecord::Base
  belongs_to :author
  belongs_to :post

  attr_accessible :author, :post, :author_id, :post_id
end
