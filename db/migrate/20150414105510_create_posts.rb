class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :title
      t.text :contents
      t.references :user, index: true
      t.datetime :publish_at
      t.boolean :is_published, default: false

      t.timestamps null: false
    end
    add_foreign_key :posts, :users
  end
end
