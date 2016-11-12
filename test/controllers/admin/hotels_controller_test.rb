require 'test_helper'

class Admin::HotelsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_hotels_index_url
    assert_response :success
  end

end
