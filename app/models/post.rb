class Post < ApplicationRecord
  belongs_to :user
  belongs_to :supplecategory, optional: true

  validates :supplecategory_id, presence: { message: "サプリ名を入力してください" }
  validates :effect, presence: { message: "本文を入力してください" }
  validates :side_effect, presence: { message: "本文を入力してください" }
  validates :supple_image, presence: { message: "画像を選択してください" }

  mount_uploader :supple_image, SuppleImageUploader
end
