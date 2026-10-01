require "test_helper"

class ContactAccessTest < ActionDispatch::IntegrationTest
  test "production contacts require configured operator credentials" do
    with_operator_credentials(nil, nil) do
      with_production_env do
        get contacts_path
        assert_response :unauthorized
        assert_equal "no-store", response.headers["Cache-Control"]

        get contacts_path(format: :json)
        assert_response :unauthorized

        get export_to_pdf_contacts_path
        assert_response :unauthorized
      end
    end

    with_operator_credentials("operator", "secret") do
      with_production_env do
        get contacts_path
        assert_response :unauthorized

        get contacts_path, headers: {
          "HTTP_AUTHORIZATION" => ActionController::HttpAuthentication::Basic.encode_credentials("operator", "wrong")
        }
        assert_response :unauthorized

        get contacts_path, headers: {
          "HTTP_AUTHORIZATION" => ActionController::HttpAuthentication::Basic.encode_credentials("operator", "secret")
        }
        assert_response :success

        get contacts_path(format: :json), headers: {
          "HTTP_AUTHORIZATION" => ActionController::HttpAuthentication::Basic.encode_credentials("operator", "secret")
        }
        assert_response :success
      end
    end
  end

  private

  def with_production_env
    original = Rails.env
    Rails.env = "production"
    yield
  ensure
    Rails.env = original
  end

  def with_operator_credentials(user, password)
    original_user = ENV["CONTACT_HTTP_USER"]
    original_password = ENV["CONTACT_HTTP_PASSWORD"]
    ENV["CONTACT_HTTP_USER"] = user
    ENV["CONTACT_HTTP_PASSWORD"] = password
    yield
  ensure
    ENV["CONTACT_HTTP_USER"] = original_user
    ENV["CONTACT_HTTP_PASSWORD"] = original_password
  end
end
