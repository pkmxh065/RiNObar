class LikesController < ApplicationController
  before_action :require_login
  before_action :set_novel

  def create
    @like = current_user.likes.build(novel_id: params[:novel_id])
    @like.save
    render_like
  end

  def destroy
    like = current_user.likes.find_by(novel_id: @novel.id)
    like&.destroy
    render_like
  end

  private

  def set_novel
    @novel = Novel.find(params[:novel_id])
  end

  def render_like
    render turbo_stream: turbo_stream.replace(
      "like-frame-#{@novel.id}",
      partial: "novels/like",
      locals: { novel: @novel }
    )
  end
end
