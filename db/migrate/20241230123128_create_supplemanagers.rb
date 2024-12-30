class CreateSupplemanagers < ActiveRecord::Migration[7.2]
  def change
    create_table :supplemanagers do |t|
      t.string :supple_name, null: false
      t.integer :remainingdays, null: false
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
