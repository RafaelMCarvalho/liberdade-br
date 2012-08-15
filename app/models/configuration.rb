# -*- encoding : utf-8 -*-
class Configuration < ActiveRecord::Base

	attr_accessible :email, :keywords, :description, :google_analytics, :facebook,
    :twitter, :footer, :donation_text, :donation_link, :donation_goal,
    :donation_collected, :site_title, :site_url

  validates_presence_of :email
  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i

  before_validation :add_protocol_to_links

  validates_format_of :site_url, :donation_link, :facebook, :twitter, :allow_blank => true, :with => /^(?:(?:https?|ftp|git):\/\/)?(?:\S+(?::\S*)?@)?(?:(?!10(?:\.\d{1,3}){3})(?!127(?:\.\d{1,3}){3})(?!169\.254(?:\.\d{1,3}){2})(?!192\.168(?:\.\d{1,3}){2})(?!172\.(?:1[6-9]|2\d|3[0-1])(?:\.\d{1,3}){2})(?:[1-9]\d?|1\d\d|2[01]\d|22[0-3])(?:\.(?:1?\d{1,2}|2[0-4]\d|25[0-5])){2}(?:\.(?:[1-9]\d?|1\d\d|2[0-4]\d|25[0-4]))|(?:(?:[a-z\u00a1-\uffff0-9]+-?)*[a-z\u00a1-\uffff0-9]+)(?:\.(?:[a-z\u00a1-\uffff0-9]+-?)*[a-z\u00a1-\uffff0-9]+)*(?:\.(?:[a-z\u00a1-\uffff]{2,})))(?::\d{2,5})?(?:\/[^\s]*)?$/i

  def add_protocol_to_links
    unless self.facebook.blank?
      self.facebook = 'http://' + self.facebook if self.facebook.match(/^(\w*):\/\//i).nil?
    end
    unless self.twitter.blank?
      self.twitter = 'http://' + self.twitter if self.twitter.match(/^(\w*):\/\//i).nil?
    end
    unless self.donation_link.blank?
      self.donation_link = 'http://' + self.donation_link if self.donation_link.match(/^(\w*):\/\//i).nil?
    end
    unless self.site_url.blank?
      self.site_url = 'http://' + self.site_url if self.site_url.match(/^(\w*):\/\//i).nil?
    end
  end
end

