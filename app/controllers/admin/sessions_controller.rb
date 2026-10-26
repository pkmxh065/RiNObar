class Admin::SessionsController < ApplicationController
  skip_before_action :require_authentication, raise: false
  include AdminAuthentication
  skip_before_action :require_admin_authentication, only: [ :new, :create ], raise: false

  def new
  end

  def create
    if admin = Admin.authenticate_by(email_address: params[:email_address], password: params[:password])
      start_new_admin_session_for(admin)
      redirect_to "/admin/dashboard"
    else
      flash.now[:alert] = "メールアドレスまたはパスワードが違います"
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    terminate_admin_session
    redirect_to admin_login_path, notice: "ログアウトしました。"
  end
end
