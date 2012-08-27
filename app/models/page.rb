# -*- encoding : utf-8 -*-
class Page < ActiveRecord::Base

	attr_accessible :title, :content, :published

  validates_presence_of :title

  PAGES = {
    :contact => 1,
    :about => 2,
    :financers => 3,
    :faq => 4,
    :send_post => 5,
    :donate => 6
  }

  def self.get_page(id)
    find_by_indicator(PAGES[id.to_sym])
  end
end
