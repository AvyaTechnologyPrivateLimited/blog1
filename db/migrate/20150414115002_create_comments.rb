class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.string :contents
      t.references :post, index: true
      t.references :user, index: true

      t.timestamps null: false
    end
    add_foreign_key :comments, :posts
    add_foreign_key :comments, :users
  end
end
