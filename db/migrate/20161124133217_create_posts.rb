class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.text :title
      t.text :content
      t.references :admin, index: true, foreign_key: true
      t.timestamps null: false
    end
  end
end
