class AddApprovedAtToPosts < ActiveRecord::Migration
  def self.up
    add_column :posts, :approved_at, :date
    Post.published.each do |post|
      post.update_attributes(approved_at: post.updated_at)
    end
  end

  def self.down
    remove_column :posts, :approved_at
  end
end