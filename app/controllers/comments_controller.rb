class CommentsController < ApplicationController
  before_action :authenticate_user!, only: %i[ create destroy ]

  def create
    @post = Post.find(params[:post_id])
    @comment = Comment.new(comment_params)
    if @comment.save
      ActionCable.server.broadcast "comment_channel", {
        action: "create",
        comment: @comment.as_json(include: :user),
        user: @comment.user.name
      }
      @post.create_notification_comment!(current_user, @comment.id)
    else
      redirect_to post_path(@post), alert: "コメントの投稿に失敗しました。"
    end
  end

  def destroy
    @post = Post.find(params[:post_id])
    @comment = Comment.find(params[:id])
    comment_id = @comment.id # 削除前にIDを保存

    if @comment.destroy
      ActionCable.server.broadcast "comment_channel", {
        action: "destroy",
        comment_id: comment_id
      }
    else
      redirect_to post_path(@comment.post), alert: "コメントの削除に失敗しました。"
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content).merge(user_id: current_user.id, post_id: params[:post_id])
  end
end
