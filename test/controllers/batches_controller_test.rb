require 'test_helper'

class BatchesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get batches_index_url
    assert_response :success
  end

  test "should get show" do
    get batches_show_url
    assert_response :success
  end

end
