class SessionsController < ApplicationController
  allow_unauthenticated_access only: %i[ new create ]
  rate_limit to: 10, within: 3.minutes, only: :create, with: -> { redirect_to new_session_path, alert: "Try again later." }

  def new
  end

  def create
    email_param = params[:email_address] || params[:email]
    if user = User.authenticate_by(email_address: email_param, password: params[:password])
      start_new_session_for user
      redirect_to user_path(user), notice: "ログインしました。"
    else
      redirect_to new_session_path, alert: "Try another email address or password."
    end
  end

  def destroy
    terminate_session
    redirect_to new_session_path, notice: "ログアウトしました。"
  end
end