class CreateComments < ActiveRecord::Migration[7.2]
  def change
    create_table :comments do |t|
      t.string :content, null: false
      t.references :user, foreign_key: true
      t.references :post, foreign_key: true
      t.timestamps
      t.index [:user_id, :post_id], unique: true
    end
  end
end
