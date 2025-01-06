class RenameColumnInUsers < ActiveRecord::Migration[7.2]
  def change
    rename_column :users, :encypted_password, :encrypted_password
  end
end
