require 'test_helper'

class Admin::PlacesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_places_index_url
    assert_response :success
  end

end
