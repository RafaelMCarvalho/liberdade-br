class ChangeDataTypeForPostPublishedAt < ActiveRecord::Migration
  def change
    change_column :posts, :published_at, :datetime, :defaut => Date.today
  end
end