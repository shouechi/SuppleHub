class PostsController < ApplicationController
    # ユーザー認証をすべてのアクションで実行。indexアクションを除く
    before_action :authenticate_user!, except: [ :index ]

  def index
    @posts = Post.order(created_at: :desc).page(params[:page]).per(21)
  end

  def show
    @post = Post.find(params[:id])
  end
end
