require 'test_helper'

class BooksControllerTest < ActionDispatch::IntegrationTest
  test "index" do
    get api_v1_books_path
    assert_response :success
  end
end
