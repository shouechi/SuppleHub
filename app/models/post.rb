class Post < ApplicationRecord
  belongs_to :user
  belongs_to :supplecategory

  validates :effect, presence: true
  validates :side_effect, presence: true
  validates :supple_image, presence: true

  mount_uploader :supple_image, SuppleImageUploader
end
