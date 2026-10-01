class ApplicationController < ActionController::Base
  before_action :prevent_contact_caching
  before_action :require_operator_login, if: -> { Rails.env.production? }

  private

  def prevent_contact_caching
    response.headers["Cache-Control"] = "no-store"
  end

  def require_operator_login
    expected_user = ENV["CONTACT_HTTP_USER"]
    expected_password = ENV["CONTACT_HTTP_PASSWORD"]

    authenticate_or_request_with_http_basic("Contacts") do |user, password|
      expected_user.present? && expected_password.present? &&
        ActiveSupport::SecurityUtils.secure_compare(user, expected_user) &&
        ActiveSupport::SecurityUtils.secure_compare(password, expected_password)
    end
  end
end
