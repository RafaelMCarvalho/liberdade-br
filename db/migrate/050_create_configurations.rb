# -*- encoding : utf-8 -*-
class CreateConfigurations < ActiveRecord::Migration
  def self.up
    create_table :configurations do |t|
      # Conctact attributes
      t.string :email

      # Social attributes
      t.string :twitter
      t.string :facebook
      t.integer :facebook_like_goal

      # Site attributes
      t.text :description
      t.text :footer
      t.text :google_analytics
      t.string :site_title
      t.string :site_url
      t.string :keywords

      # Donation attributes
      t.text :donation_text
      t.float :donation_goal
      t.float :donation_collected

      # Sponsor
      t.string :ad_title
      t.string :ad_url
      t.boolean :ad_new_tab
      t.boolean :ad_published
      t.has_attached_file :ad_image
      t.timestamps

      # Realization
      t.string :realization_title
      t.has_attached_file :realization_image
      t.string :realization_url
    end
  end

  def self.down
    drop_table :configurations
  end
end
