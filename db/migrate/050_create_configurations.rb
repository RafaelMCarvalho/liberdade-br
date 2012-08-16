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
      t.string :donation_link
      t.float :donation_goal
      t.float :donation_collected

      t.timestamps
    end
  end

  def self.down
    drop_table :configurations
  end
end

