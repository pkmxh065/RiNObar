module AdminAuthentication
  extend ActiveSupport::Concern

  included do
    before_action :require_admin_authentication
    helper_method :authenticated_admin?
  end

  private

  def authenticated_admin?
    Current.admin_session ||= Session.find_by(id: session[:admin_session_id])&.admin
  end

  def require_admin_authentication
    unless authenticated_admin?
      session[:admin_return_to_after_authentication] = request.url
      redirect_to new_admin_session_path, alert: "管理者ログインが必要です。"
    end
  end

  def start_new_admin_session_for(admin)
    session_record = admin.sessions.create!(user_agent: request.user_agent, ip_address: request.remote_ip)
    session[:admin_session_id] = session_record.id
  end

  def terminate_admin_session
    Session.find_by(id: session[:admin_session_id])&.destroy
    session[:admin_session_id] = nil
  end
end