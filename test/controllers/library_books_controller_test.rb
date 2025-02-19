require "test_helper"

class LibraryBooksControllerTest < ActionDispatch::IntegrationTest
  setup do
    @admin = users(:admin)
    @user = users(:one)
    @library_book = library_books(:one)

    sign_in @admin # Log in as admin
  end

  test "should get index" do
    get library_books_url
    assert_response :success
  end

  test "should create book if user is admin" do
    assert_difference("LibraryBook.count", 1) do
      post library_books_url, params: { library_book: { title: "New Book", author: "Author", isbn: "123456" } }
    end

    assert_redirected_to library_book_path(assigns(:library_book))
    assert_equal "Book was successfully created.", flash[:notice]
  end

  test "should not allow non-admins to create books" do
    sign_in @user # Switch to a regular user

    assert_no_difference("LibraryBook.count") do
      post library_books_url, params: { library_book: { title: "Unauthorized", author: "Hacker", isbn: "111111" } }
    end

    assert_redirected_to library_books_url
    assert_equal "You are not authorized to add books.", flash[:alert]
  end

  test "should update book" do
    patch library_book_url(@library_book), params: { library_book: { title: "Updated Title" } }

    @library_book.reload
    assert_equal "Updated Title", @library_book.title
    assert_redirected_to library_book_url(@library_book)
    assert_equal "Book was successfully updated.", flash[:notice]
  end

  test "should destroy book" do
    assert_difference("LibraryBook.count", -1) do
      delete library_book_url(@library_book)
    end

    assert_redirected_to library_books_url
    assert_equal "Book was successfully destroyed.", flash[:notice]
  end
end
