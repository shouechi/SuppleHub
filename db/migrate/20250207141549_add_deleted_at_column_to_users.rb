class AddDeletedAtColumnToUsers < ActiveRecord::Migration[7.2]
  def change
    add_column :users, :deleted_at, :datetime
  end
end
