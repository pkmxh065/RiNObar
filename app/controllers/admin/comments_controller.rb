class Admin::CommentsController < Admin::BaseController

  def index
    @comments = Comment.includes(:user, :novel).order(created_at: :desc).page(params[:page]).per(10)
  end

  def show
    @comment = Comment.includes(:novel).find(params[:id])
  end

  def update
    if @comment.update(comment_params)
      redirect_to admin_comment_path(@comment), notice: "コメントを更新しました"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    redirect_to admin_comments_path, notice: "コメントを削除しました"
  end

  private

  def set_review
    @comment = Comment.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:title, :body, :rating)
  end
end