class AddAbstentionRateToPosts < ActiveRecord::Migration
  def self.up
    add_column :posts, :abstention_rate, :float, :default => 0.0
  end

  def self.down
    remove_column :posts, :abstention_rate
  end
end
