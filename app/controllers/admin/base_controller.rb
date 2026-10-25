class Admin::BaseController < ApplicationController
  before_action :require_admin

    private

    def require_admin
      redirect_to login_path, alert: "ログインしてください" unless Current.user
    end
end