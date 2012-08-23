# -*- encoding : utf-8 -*-
class Configuration < ActiveRecord::Base
  attr_accessible :email, :keywords, :description, :google_analytics, :facebook,
    :twitter, :footer, :donation_text, :donation_link, :donation_goal,
    :donation_collected, :site_title, :site_url, :facebook_like_goal,
    :sponsor_url, :sponsor_image, :sponsor_new_tab, :sponsor_published,
    :sponsor_title, :realization_url, :realization_image, :realization_title

  attr_accessor :delete_sponsor_image, :delete_realization_image

  has_attached_file :sponsor_image,
    :path => ':rails_root/public/system/configuration/:id/sponsor/:style/:filename',
    :url => '/system/configuration/:id/sponsor/:style/:filename',
    :styles => { :banner => '970x410#', :thumb => '97x41#' }

  validates_attachment_content_type :sponsor_image,
    :content_type => /^image\/(jpg|jpeg|pjpeg|png|x-png|gif)$/,
    :message => 'formato inválido'

  has_attached_file :realization_image,
    :path => ':rails_root/public/system/configuration/:id/realization/:style/:filename',
    :url => '/system/configuration/:id/realization/:style/:filename',
    :styles => { :normal => '250x56#', :thumb => '97x41#' }

  validates_attachment_content_type :realization_image,
    :content_type => /^image\/(jpg|jpeg|pjpeg|png|x-png|gif)$/,
    :message => 'formato inválido'


  before_validation { self.sponsor_image.clear if self.delete_sponsor_image == '1' }
  before_validation { self.realization_image.clear if self.delete_realization_image == '1' }
  before_validation :add_protocol_to_links

  validates_presence_of :email
  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i
  validates_format_of :realization_url, :sponsor_url, :site_url, :donation_link, :facebook, :twitter, :allow_blank => true, :with => /^(?:(?:https?|ftp|git):\/\/)?(?:\S+(?::\S*)?@)?(?:(?!10(?:\.\d{1,3}){3})(?!127(?:\.\d{1,3}){3})(?!169\.254(?:\.\d{1,3}){2})(?!192\.168(?:\.\d{1,3}){2})(?!172\.(?:1[6-9]|2\d|3[0-1])(?:\.\d{1,3}){2})(?:[1-9]\d?|1\d\d|2[01]\d|22[0-3])(?:\.(?:1?\d{1,2}|2[0-4]\d|25[0-5])){2}(?:\.(?:[1-9]\d?|1\d\d|2[0-4]\d|25[0-4]))|(?:(?:[a-z\u00a1-\uffff0-9]+-?)*[a-z\u00a1-\uffff0-9]+)(?:\.(?:[a-z\u00a1-\uffff0-9]+-?)*[a-z\u00a1-\uffff0-9]+)*(?:\.(?:[a-z\u00a1-\uffff]{2,})))(?::\d{2,5})?(?:\/[^\s]*)?$/i

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
    unless self.sponsor_url.blank?
      self.sponsor_url = 'http://' + self.sponsor_url if self.sponsor_url.match(/^(\w*):\/\//i).nil?
    end
    unless self.realization_url.blank?
      self.realization_url = 'http://' + self.realization_url if self.realization_url.match(/^(\w*):\/\//i).nil?
    end
  end
end

