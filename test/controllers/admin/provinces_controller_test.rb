require 'test_helper'

class Admin::ProvincesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_provinces_index_url
    assert_response :success
  end

end
