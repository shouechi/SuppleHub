class PostForm
  include ActiveModel::Model
  include ActiveModel::Attributes
  extend CarrierWave::Mount

  attribute :effect, :string
  attribute :side_effect, :string
  attribute :supple_image, :string
  attribute :supple_image_cache, :string
  attribute :user_id, :integer
  attribute :supplecategory_id, :integer

  mount_uploader :supple_image, SuppleImageUploader

  validates :supplecategory_id,  presence: true
  validates :effect,  presence: true
  validates :side_effect,  presence: true
  validates :supple_image,  presence: false
  validates :supple_image_cache, presence: false

  # モデルからの属性を取得するためのメソッド
  def initialize(attributes = {})
    @post = attributes.delete(:post)
    super(attributes)

    if @post.present?
      self.supplecategory_id = @post.supplecategory_id
      self.effect = @post.effect
      self.side_effect = @post.side_effect
      self.supple_image = @post.supple_image
      self.user_id = @post.user_id
    end
  end

  # IDを取得するためのメソッド
  def id
    @post&.id
  end

  def save
    return false if invalid?

    ActiveRecord::Base.transaction do
      post = build_post()
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

  def update(attributes)
    assign_attributes(attributes)
    return false unless valid?

    ActiveRecord::Base.transaction do
      @post.update!(
        supplecategory_id: supplecategory_id,
        effect: effect,
        side_effect: side_effect,
        supple_image: supple_image,
        supple_image_cache: supple_image_cache
      )
      true
    rescue ActiveRecord::RecordInvalid
      false
    end
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
