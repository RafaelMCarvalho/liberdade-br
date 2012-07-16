class CreateAuthorPosts < ActiveRecord::Migration
  def change
    create_table :author_posts do |t|
      t.references :author
      t.references :post

      t.timestamps
    end
  end
end
