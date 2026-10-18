class NovelsController < ApplicationController
  allow_unauthenticated_access only: [ :index, :show ]
  before_action :ensure_correct_user, only: [ :edit, :update ]

  def new
    @novel = Novel.new
  end

  def index
    @novels = Novel.all
  end

  def show
    @novel = Novel.find(params[:id])
    session_record = find_session_by_cookie
    @current_user = session_record&.user
  end

  def edit
    @novel = Novel.find(params[:id])
    session_record = find_session_by_cookie
    @current_user = session_record&.user
  end

  def create
    @novel = Novel.new(novel_params)
    @novel.user_id = Current.session.user.id
    if @novel.save
      redirect_to @novel, notice: "投稿が完了しました。"
    else
      render "new", status: :unprocessable_entity
    end
  end

  def update
    @novel = Novel.find(params[:id])
    if @novel.update(novel_params)
      redirect_to novel_path(@novel), notice: "投稿内容を変更しました。"
    else
      flash.now[:alert] = @novel.errors.full_messages.join("、")
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @novel = Novel.find(params[:id])
    @user = @novel.user
    if @novel.destroy
      redirect_to user_path(@user), notice: "削除が完了しました。", status: :see_other
    end
  end

  private

  def ensure_correct_user
    @novel = Novel.find(params[:id])
    if @novel.user != Current.user
      redirect_to user_path(current_user), notice: "別ユーザーの投稿のため編集できません。"
    end
  end

  def novel_params
    params.require(:novel).permit(:title, :genre_main, :genre_sub, :story, :thought)
  end
end
