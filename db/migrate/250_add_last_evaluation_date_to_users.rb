class AddLastEvaluationDateToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :last_evaluation_date, :datetime
  end

  def self.down
    remove_column :users, :last_evaluation_date
  end
end
