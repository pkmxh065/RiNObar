class UsersController < ApplicationController
  allow_unauthenticated_access only: [ :new, :create, :index, :withdraw_done ]
  before_action :require_login, only: [ :edit, :update, :unsubscribe, :withdraw ]
  before_action :ensure_correct_user, only: [ :edit, :update, :unsubscribe, :withdraw ]

  def new
    @user = User.new
  end

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(user_params)
    if @user.save
      start_new_session_for @user
      redirect_to about_path, notice: "ユーザー登録が完了しました。"
    else
      @user.errors.full_messages
      render :new, status: :unprocessable_entity
    end
  end

  def update
    @user = User.find(params[:id])
    if params[:user][:password].blank? && params[:user][:password_confirmation].blank?
      params[:user].delete(:password)
      params[:user].delete(:passrord_confirmation)
    end
    if @user.update(user_params)
      redirect_to user_path(@user), notice: "ユーザー情報を変更しました。"
    else
      render "edit", status: :unprocessable_entity
    end
  end

  def destroy
    @user = User.find(params[:id])
    if @user.destroy
      redirect_to about_path, notice: "ログアウトしました。"
    else
      render show, status: :unprocessable_entity
    end
  end

  def unsubscribe
    @user = User.find(params[:id])
  end

  def withdraw
    @user = User.find(params[:id])
    @user.destroy
    reset_session
    redirect_to withdraw_done_users_path
  end

  def withdraw_done
  end
  
  private

  def ensure_correct_user
    @user = User.find(params[:id])
    unless current_user
      redirect_to new_session_path, notice: "ログインしてください。"
    end
    if current_user != @user
      redirect_to user_path(current_user), notice: "別ユーザーの編集画面のためアクセスできません。"
    end
  end
  
  def user_params
    params.require(:user).permit(:name, :email_address, :password, :password_confirmation, :introduction, :image)
  end
end
