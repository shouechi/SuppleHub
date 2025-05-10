class Post < ApplicationRecord
  belongs_to :user
  belongs_to :supplecategory, optional: true
  has_many :comments, dependent: :destroy
  has_many :notifications, dependent: :destroy

 # ransackで検索可能なカラムを指定
 def self.ransackable_attributes(auth_object = nil)
  [ "created_at", "effect", "id", "side_effect", "supple_image", "supplecategory_id", "updated_at", "user_id", "supplecategory_name" ]
 end

  # ransackで検索可能な関連（アソシエーション）を指定
  def self.ransackable_associations(auth_object = nil)
    [ "supplecategory" ]
  end

  # コメント通知メソッド
  def create_notification_comment!(current_user, comment_id)
    # 自分以外にコメントしている人を全て取得し、全員に通知を送信
    temp_ids = Comment.select(:user_id).where(post_id: id).where.not(user_id: current_user.id).distinct
    temp_ids.each do |temp_id|
      save_notification_comment!(current_user, comment_id, user_id)
    end
    # まだ誰もコメントしていない場合、投稿者に通知を送信
    save_notification_comment!(current_user, comment_id, user_id) if temp_ids.blank?
    end

    def save_notification_comment!(current_user, comment_id, visited_id)
      # コメントは複数回することが考えられるため、1つの投稿に複数回通知
      notifications = current_user.active_notifications.new(
        post_id: id,
        comment_id: comment_id,
        visited_id: visited_id,
        action: "comment"
      )
      # 自分の投稿に対するコメントの場合は通知済み
      if notifications.visiter_id == notifications.visited_id
        notifications.checked = true
      end
      notifications.save if notifications.valid?
    end
end
