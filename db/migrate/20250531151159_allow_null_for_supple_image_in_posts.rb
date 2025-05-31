class AllowNullForSuppleImageInPosts < ActiveRecord::Migration[7.2]
  def change
    change_column_null :posts, :supple_image, true
  end
end
