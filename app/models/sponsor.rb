# -*- encoding : utf-8 -*-

class Sponsor < ActiveRecord::Base
  has_attached_file :image,
    :path => ":rails_root/public/system/sponsors/:id/:style/:filename",
    :url => "/system/sponsors/:id/:style/:filename",
    :styles => {
      :small => '315x100#', :thumb => '125x50#'
    }

  validates_attachment_content_type :image,
    :content_type => /^image\/(jpg|jpeg|pjpeg|png|x-png|gif)$/,
    :message => 'com formato inválido'

  attr_accessible :name, :link, :image

  attr_accessor :delete_image

  before_validation { self.image.clear if self.delete_image == '1' }
  before_validation :add_protocol_to_link

  validates_presence_of :name
  validates_format_of :link, :allow_blank => true, :with => /^(?:(?:https?|ftp|git):\/\/)?(?:\S+(?::\S*)?@)?(?:(?!10(?:\.\d{1,3}){3})(?!127(?:\.\d{1,3}){3})(?!169\.254(?:\.\d{1,3}){2})(?!192\.168(?:\.\d{1,3}){2})(?!172\.(?:1[6-9]|2\d|3[0-1])(?:\.\d{1,3}){2})(?:[1-9]\d?|1\d\d|2[01]\d|22[0-3])(?:\.(?:1?\d{1,2}|2[0-4]\d|25[0-5])){2}(?:\.(?:[1-9]\d?|1\d\d|2[0-4]\d|25[0-4]))|(?:(?:[a-z\u00a1-\uffff0-9]+-?)*[a-z\u00a1-\uffff0-9]+)(?:\.(?:[a-z\u00a1-\uffff0-9]+-?)*[a-z\u00a1-\uffff0-9]+)*(?:\.(?:[a-z\u00a1-\uffff]{2,})))(?::\d{2,5})?(?:\/[^\s]*)?$/i

  def add_protocol_to_link
    unless self.link.blank?
      self.link = 'http://' + self.link if self.link.match(/^(\w*):\/\//i).nil?
    end
  end
end
