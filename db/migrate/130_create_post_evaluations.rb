class CreatePostEvaluations < ActiveRecord::Migration
  def change
    create_table :post_evaluations do |t|
      t.references :user
      t.references :post
      t.boolean :accept

      t.timestamps
    end
  end
end
