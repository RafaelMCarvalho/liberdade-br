class AddLastEvaluationDateToPosts < ActiveRecord::Migration
  def self.up
    add_column :posts, :last_evaluation_date, :datetime
  end

  def self.down
    remove_column :posts, :last_evaluation_date
  end
end
