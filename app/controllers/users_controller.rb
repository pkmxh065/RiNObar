class UsersController < ApplicationController
  before_action :authenticate_user!
  allow_unauthenticated_access only: [:new, :create, :index, :edit, :show]

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
      p @user.errors.full_messages
      render :new, status: :unprocessable_entity
    end
  end

  def update
    user = User.find(params[:id])
    if user.update(user_params)
      redirect_to user_path(user)
    else
      render edit, status: :unprocessable_entity
    end
  end

  def destroy
    user = User.find(params[:id])
    if user.destroy
      redirect_to about_path
    else
      render show, status: :unprocessable_entity
    end
  end

  def unsubscribe
    @user = current_user
  end

  def withdraw
    @user = current_user
    @user.update(is_deleted: true)
    reset_session
    redirect_to withdraw_done_user_path
  end

  def withdraw_done
  end
  
  private

  def user_params
    params.require(:user).permit(:name, :email_address, :password, :password_confirmation, :image)
  end
end
