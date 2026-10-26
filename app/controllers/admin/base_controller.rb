class Admin::BaseController < ApplicationController
  skip_before_action :require_authentication, raise: false

  include AdminAuthentication

  private

  def require_admin
    redirect_to login_path, alert: "ログインしてください" unless Current.user
  end
end