class PostsController < ApplicationController
    # ユーザー認証をすべてのアクションで実行。index,showアクションを除く
    before_action :authenticate_user!, except: [ :index, :show ]

  def index
    @posts = Post.order(created_at: :desc).page(params[:page]).per(21)
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user = current_user # 現在のユーザーを関連付ける

    # サプリメントカテゴリの処理
    if params[:post][:supplecategory_id].present?
      @supplecategory = Supplecategory.find_or_create_by(name: params[:post][:supplecategory_id])

      unless @supplecategory.persisted?
        flash.now[:alert] = "カテゴリの作成に失敗しました"
        render :new, status: :unprocessable_entity
        return
      end

      @post.supplecategory_id = @supplecategory.id
    end

    if @post.save
      redirect_to posts_path, notice: "投稿が成功しました！"
    else
      flash.now[:alert] = "投稿の作成に失敗しました"
      Rails.logger.error @post.errors.full_messages.join(", ")
      render :new, status: :unprocessable_entity
    end
  end


  def edit
    @post = Post.find(params[:id])
  end

  def update
  @post = Post.find(params[:id])

  # サプリメントカテゴリの処理
  if params[:post][:supplecategory_id].present?
    @supplecategory = Supplecategory.find_or_create_by(name: params[:post][:supplecategory_id])

    unless @supplecategory.persisted?
      flash.now[:alert] = "カテゴリの作成に失敗しました"
      render :edit, status: :unprocessable_entity
    end
  end

  # 投稿の更新
  if @post.update(post_params.merge(supplecategory_id: @supplecategory&.id))
    redirect_to posts_path, notice: "投稿が成功しました！"
  else
    flash.now[:alert] = "投稿の更新に失敗しました"
    render :edit, status: :unprocessable_entity
  end
end



  def show
    @post = Post.find(params[:id])
  end

  private

  def post_params
    params.require(:post).permit(:supplecategory_id, :effect, :side_effect, :supple_image, :supple_image_cache)
  end
end
