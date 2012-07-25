class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.references :blog

      t.string :title
      t.string :url
      t.text :content
      t.date :published_at

      t.timestamps
    end
  end
end
