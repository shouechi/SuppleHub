class PostsController < ApplicationController
    # ユーザー認証をすべてのアクションで実行。indexアクションを除く
    before_action :authenticate_user!, except: [ :index ]

  def index
    @posts = Post.order(created_at: :desc).page(params[:page]).per(21)
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user = current_user # 現在のユーザーを関連付ける
    # 新しいサプリカテゴリを作成
    if params[:post][:supplecategory_id].present?
      @supplecategory = Supplecategory.new(name: params[:post][:supplecategory_id])

      if @supplecategory.save
        @post.supplecategory_id = @supplecategory.id
      else
        flash.now[:alert] = 'カテゴリの作成に失敗しました'
        render :new, status: :unprocessable_entity
      end
    end

    if @post.save
      redirect_to posts_path, notice: '投稿が成功しました！'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @post = Post.find(params[:id])
  end


  def show
    @post = Post.find(params[:id])
  end

  private

  def post_params
    params.require(:post).permit(:supplecategory_id, :effect, :side_effect, :supple_image, :supple_image_cache)
  end
end
