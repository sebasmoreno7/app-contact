require "test_helper"

class RemoteIpSecurityTest < ActiveSupport::TestCase
  test "proxy reports the same client through both forwarding headers" do
    response = resolve_ip("198.51.100.7", "198.51.100.7")
    assert_equal ["198.51.100.7"], response[2]
  end

  test "conflicting Forwarded and X-Forwarded-For values cannot spoof the client" do
    assert_raises(ActionDispatch::RemoteIp::IpSpoofAttackError) do
      resolve_ip("203.0.113.12", "198.51.100.7")
    end
  end

  private

  def resolve_ip(forwarded, x_forwarded_for)
    endpoint = lambda do |env|
      [200, { "content-type" => "text/plain" }, [ActionDispatch::Request.new(env).remote_ip]]
    end
    middleware = ActionDispatch::RemoteIp.new(endpoint)
    env = Rack::MockRequest.env_for("/", "REMOTE_ADDR" => "10.0.0.1",
      "HTTP_FORWARDED" => "for=#{forwarded}",
      "HTTP_X_FORWARDED_FOR" => x_forwarded_for)
    middleware.call(env)
  end
end
