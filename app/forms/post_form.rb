class PostForm
  include ActiveModel::Model
  include ActiveModel::Attributes
  extend CarrierWave::Mount

  attribute :effect, :string
  attribute :side_effect, :string
  attribute :supple_image, :string
  attribute :user_id, :integer
  attribute :supplecategory_id, :integer

  mount_uploader :supple_image, SuppleImageUploader

  validates :supplecategory_id, presence: { message: "サプリ名を入力してください" }
  validates :effect, presence: { message: "本文を入力してください" }
  validates :side_effect, presence: { message: "本文を入力してください" }
  validates :supple_image, presence: { message: "画像を選択してください" }

  # モデルからの属性を取得するためのメソッド
  def initialize(attributes = {})
    @post = attributes.delete(:post)
    super(attributes)
  end

  def save
    return false if invalid?

    ActiveRecord::Base.transaction do
      post = build_post
      post.save
      # トランザクションが成功した場合、trueを返す
      true
    rescue ActiveRecord::RecordInvalid
      # 保存に失敗した場合、falseを返す
      false
    end
  end
  # サプリカテゴリを取得するメソッド
  def supplecategory
    Supplecategory.find_by(id: supplecategory_id) if supplecategory_id.present?
  end

  private

  def build_post
    @post = Post.new(
      supplecategory_id: supplecategory_id,
      effect: effect,
      side_effect: side_effect,
      supple_image: supple_image,
      user_id: user_id
    )
  end
end
