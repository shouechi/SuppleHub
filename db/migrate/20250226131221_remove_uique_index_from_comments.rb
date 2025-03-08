class RemoveUiqueIndexFromComments < ActiveRecord::Migration[7.2]
  def change
    remove_index :comments, name: "index_comments_on_user_id_and_post_id"
  end
end
