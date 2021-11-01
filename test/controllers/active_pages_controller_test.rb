require 'test_helper'

class ActivePagesControllerTest < ActionDispatch::IntegrationTest
  test "should get welcome" do
    get active_pages_welcome_url
    assert_response :success
  end

end
