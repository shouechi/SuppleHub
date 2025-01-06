class CreateUsers < ActiveRecord::Migration[7.2]
  def change
    create_table :users do |t|
      t.string :name, null: false
      t.string :email, index: { unique: true }
      t.string :encypted_password, null: false
      t.timestamps
    end
  end
end
