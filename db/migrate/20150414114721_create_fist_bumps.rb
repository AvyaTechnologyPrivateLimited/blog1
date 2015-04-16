class CreateFistBumps < ActiveRecord::Migration
  def change
    create_table :fist_bumps do |t|
      t.references :post, index: true
      t.references :user, index: true
      t.boolean :is_like, default: false
      t.timestamps null: false
    end
    add_foreign_key :fist_bumps, :posts
    add_foreign_key :fist_bumps, :users
  end
end
