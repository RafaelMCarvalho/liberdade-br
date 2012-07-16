class Blog < ActiveRecord::Base
  attr_accessible :description, :link, :name, :rss

  validates_presence_of :name, :link
end
