class AddConfigurationIdToCategories < ActiveRecord::Migration
  def self.up
    add_column :categories, :configuration_id, :integer
  end

  def self.down
    remove_column :categories, :configuration_id
  end
end