class PostsController < ApplicationController
  # ユーザー認証をすべてのアクションで実行。index,showアクションを除く
  before_action :authenticate_user!, except: [ :index, :show ]

  # app/controllers/posts_controller.rb
  def index
    @q = Post.ransack(params[:q])
    @posts = @q.result.includes(:supplecategory).distinct.page(params[:page]).per(10)
  end

  def autocomplete
    @q = Post.ransack(params[:q])
    @posts = @q.result(distinct: true).limit(10)

    render json: @posts.map { |post|
      {
        id: post.id,
        effect: post.effect,
        side_effect: post.side_effect
      }
    }
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user = current_user # 現在のユーザーを関連付け

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
    @post = current_user.posts.find(params[:id])
  end

  def update
    @post = current_user.posts.find(params[:id])

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
    redirect_to posts_path, notice: "更新が成功しました！"
  else
    flash.now[:alert] = "投稿の更新に失敗しました"
    render :edit, status: :unprocessable_entity
  end
end

  def show
    @post = Post.find(params[:id])
    @comment = Comment.new
    @comments = @post.comments.includes(:user).order(created_at: :desc)
  end

  def destroy
    @post = current_user.posts.find(params[:id])
    @post.destroy
    redirect_to posts_path, notice: "投稿を削除しました"
  end

  private

  def post_params
    params.require(:post).permit(:supplecategory_id, :effect, :side_effect, :supple_image, :supple_image_cache)
  end
end
