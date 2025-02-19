require "test_helper"

class BorrowingsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one) # Assuming you have fixtures for users
    @library_book = library_books(:one) # Assuming you have fixtures for books
    @borrowing = borrowings(:one) # Assuming you have fixtures for borrowings

    sign_in @user # Devise helper to log in the user
  end

  test "should get index" do
    get borrowings_url
    assert_response :success
    assert_not_nil assigns(:borrowings)
  end

  test "should create borrowing if book is available" do
    LibraryBook.any_instance.stubs(:available?).returns(true)

    assert_difference("Borrowing.count", 1) do
      post borrowings_url, params: { library_book_id: @library_book.id }
    end

    assert_redirected_to library_books_url
    assert_equal "Book borrowed successfully!", flash[:notice]
  end

  test "should not create borrowing if book is unavailable" do
    LibraryBook.any_instance.stubs(:available?).returns(false)

    assert_no_difference("Borrowing.count") do
      post borrowings_url, params: { library_book_id: @library_book.id }
    end

    assert_redirected_to library_book_url(@library_book)
    assert_equal "This book is currently unavailable.", flash[:alert]
  end

  test "should return borrowed book" do
    assert_not @borrowing.returned

    delete borrowing_url(@borrowing)

    @borrowing.reload
    assert @borrowing.returned
    assert_redirected_to library_books_url
    assert_equal "Book returned successfully!", flash[:notice]
  end
end
