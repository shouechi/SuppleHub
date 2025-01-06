class CreatePosts < ActiveRecord::Migration[7.2]
  def change
    create_table :posts do |t|
      t.text :effect, null: false
      t.text :side_effect, null: false
      t.string :supple_image, null: false
      t.references :user, null: false, foreign_key: true
      t.references :supplecategory, foreign_key: true
      t.timestamps
    end
  end
end
