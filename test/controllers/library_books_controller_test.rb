require "test_helper"

class LibraryBooksControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get library_books_index_url
    assert_response :success
  end

  test "should get show" do
    get library_books_show_url
    assert_response :success
  end

  test "should get new" do
    get library_books_new_url
    assert_response :success
  end

  test "should get create" do
    get library_books_create_url
    assert_response :success
  end

  test "should get edit" do
    get library_books_edit_url
    assert_response :success
  end

  test "should get update" do
    get library_books_update_url
    assert_response :success
  end

  test "should get destroy" do
    get library_books_destroy_url
    assert_response :success
  end
end
