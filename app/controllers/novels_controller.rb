class NovelsController < ApplicationController
  allow_unauthenticated_access only: [:index, :show]

  def new
    @novel = Novel.new
  end

  def index
    @novels = Novel.all
  end

  def show
    @novel = Novel.find(params[:id])
  end

  def edit
    @novel = Novel.find(params[:id])
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
      redirect_to novels_path
    else
      render edit, status: :unprocessable_entity
    end
  end

  def destroy
    @novel = Novel.find(params[:id])
    if @novel.destroy
      redirect_to novels_path, notice: "削除が完了しました。"
    end
  end

  private
  
  def novel_params
    params.require(:novel).permit(:title, :genre, :story, :thought)
  end
end
