require 'test_helper'

class UserControllerTest < ActionDispatch::IntegrationTest
  test "should get show_profile" do
    get user_show_profile_url
    assert_response :success
  end

end
