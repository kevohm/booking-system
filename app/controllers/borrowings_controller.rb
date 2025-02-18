# app/controllers/borrowings_controller.rb
class BorrowingsController < ApplicationController
  def create
    library_book = LibraryBook.find(params[:library_book_id])

    borrowing = current_user.borrowings.new(library_book: library_book)

    if borrowing.save
      redirect_to profile_path(current_user), notice: "Book borrowed successfully!"
    else
      redirect_to library_book_path(library_book), alert: borrowing.errors.full_messages.to_sentence
    end
  end

  def destroy
    borrowing = current_user.borrowings.find(params[:id])
    borrowing.update(returned: true)
    redirect_to user_path(current_user), notice: "Book returned successfully!"
  end
end
