class Admin::UsersController < Admin::BaseController
  before_action :set_user, only: %i[ show destroy ]
  def index
    @users = User.where(admin: [false, nil]).order(created_at: :desc).page(params[:page]).per(10)
  end

  def show
  end

  def edit
  end
  
  def destroy
    @user = User.find(params[:id])
    if @user == Current.user
      redirect_to admin_users_path, alert: "自分自身を削除することはできません。"
    else
      @user.destroy
      redirect_to admin_users_path, notice: "ユーザー「#{@user.name}」を削除しました。"
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :email_address)
  end
end