class SearchesController < ApplicationController
  before_action :require_login

  def search
    @search_target = params[:search_target]
    @search_field = params[:search_field]
    @search_word = params[:search_word]

    word = "%#{@search_word}%"

    if @search_target == "user"
      @results = User.where("name LIKE ?", word)
    elsif @search_target == "novel"
      case @search_field
      when "title"
        @results = Novel.where("title LIKE ?", word)
      when "genre_main"
        @results = Novel.where("genre_main LIKE ?", word)
      when "genre_sub"
        @results = Novel.where("genre_sub LIKE ?", word)
      when "story"
        @results = Novel.where("story LIKE ?", word)
      else
        @results = Novel.all
      end
    else
      @results = []
    end
  end
end
