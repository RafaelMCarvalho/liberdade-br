# -*- encoding : utf-8 -*-
class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.references :blog

      t.string :title
      t.string :url
      t.text :content
      t.text :hilight
      t.float :approval_rate, :default => 0.0
      t.float :reproval_rate, :default => 0.0
      t.boolean :published
      t.date :published_at, :defaut => Date.today
      t.integer :moderator_counter, :default => 0
      t.integer :criterion_for_publication, :default => Post::CRITERION_FOR_PUBLICATION[:by_moderation]

      t.timestamps
    end
  end
end
