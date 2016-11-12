require 'test_helper'

class Admin::PlacePhotosControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_place_photos_index_url
    assert_response :success
  end

end
