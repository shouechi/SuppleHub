class Post < ApplicationRecord
  belongs_to :user
  belongs_to :supplecategory, optional: true

  validates :supplecategory_id, presence: { message: "サプリ名を入力してください" }
  validates :effect, presence: { message: "本文を入力してください" }
  validates :side_effect, presence: { message: "本文を入力してください" }
  validates :supple_image, presence: { message: "画像を選択してください" }

  mount_uploader :supple_image, SuppleImageUploader


 # ransackで検索可能なカラムを指定
 def self.ransackable_attributes(auth_object = nil)
  [ "created_at", "effect", "id", "side_effect", "supple_image", "supplecategory_id", "updated_at", "user_id", "supplecategory_name" ]
 end

# ransackで検索可能な関連（アソシエーション）を指定
def self.ransackable_associations(auth_object = nil)
  [ "supplecategory" ]
end
end
