# -*- encoding : utf-8 -*-
class CreateConfigurations < ActiveRecord::Migration
  def self.up
    create_table :configurations do |t|
      t.string :email
      t.string :keywords
      t.string :twitter
      t.string :facebook
      t.text :description
      t.text :footer
      t.text :google_analytics

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

