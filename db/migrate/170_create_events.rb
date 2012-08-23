# -*- encoding : utf-8 -*-

class CreateEvents < ActiveRecord::Migration
  def self.up
    create_table :events do |t|
      t.string :name
      t.string :link
      t.date :date
      t.text :description
      t.string :local
      t.boolean :published

      t.string :image_file_name
      t.string :image_content_type
      t.integer :image_file_size
      t.datetime :image_updated_at

      t.timestamps
    end
  end

  def self.down
    drop_table :events
  end
end
