class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.references :blog

      t.string :title
      t.string :url
      t.text :content
      t.float :approval_rate, :default => 0.0
      t.float :reproval_rate, :default => 0.0
      t.boolean :published
      t.date :published_at

      t.timestamps
    end
  end
end
