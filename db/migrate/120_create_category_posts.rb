# -*- encoding : utf-8 -*-
class CreateCategoryPosts < ActiveRecord::Migration
  def change
    create_table :category_posts do |t|
      t.references :category
      t.references :post

      t.timestamps
    end
  end
end
