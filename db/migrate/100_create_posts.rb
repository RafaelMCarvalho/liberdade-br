class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.references :blog

      t.string :title
      t.date :published_at
      t.text :content
      t.float :approval_rate, :default => 0.0
      t.float :reproval_rate, :default => 0.0
      t.boolean :published

      t.timestamps
    end
  end
end
