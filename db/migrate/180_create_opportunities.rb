# -*- encoding : utf-8 -*-
class CreateOpportunities < ActiveRecord::Migration
  def self.up
    create_table :opportunities do |t|
      t.string :title
      t.text :content
      t.boolean :published, :default => true

      t.timestamps
    end
  end

  def self.down
    drop_table :opportunities
  end
end

