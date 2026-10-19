class CommentsController < ApplicationController
  before_action require_login only: [ :create, :destroy ]

  def create
    @novel = Novel.find(params[:novel_id])
    @comment = @novel.comments.build(comment_params)
    @comment.user_id = current_user.id
    if @comment.save
      redirectt_to @novel, notice: "コメントを投稿しました。"
    else
      render @novel, alert: "コメントの投稿に失敗しました。"
    end
  end

  def destroy
    @comment = current_user.comments.find(params[:id])
    @comment.destroy
    redirect_to novel_path(params[:novel_id]), notice: "コメントを昨辞しました。"
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end
end
