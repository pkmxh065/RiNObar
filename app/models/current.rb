class Current < ActiveSupport::CurrentAttributes
  attribute :session
  attribute :admin_session
  delegate :user, to: :session, allow_nil: true
  delegate :admin, to: :session, allow_nil: true
  module Authorization
    extend ActiveSupport::Concern

    class_methods do
      def admin_access_only(**options)
        before_action :require_admin, **options
      end
    end

    private

    def require_admin
      redirect_to root_path, alert: "権限がありません" unless Current.user&.admin?
    end
  end
end
