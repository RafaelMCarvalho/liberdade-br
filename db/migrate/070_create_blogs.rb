# -*- encoding : utf-8 -*-
class CreateBlogs < ActiveRecord::Migration
  def change
    create_table :blogs do |t|
      t.string :name
      t.string :link
      t.string :rss
      t.text :description

      t.timestamps
    end
  end
end
