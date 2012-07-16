class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.references :blog

      t.string :title
      t.date :published_at
      t.text :content

      t.timestamps
    end
  end
end
