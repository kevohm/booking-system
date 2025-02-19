class BorrowingsController < ApplicationController
  before_action :set_borrowing, only: %i[destroy]
  def index
    @borrowings = current_user.borrowings
  end

  def create
    library_book = LibraryBook.find(params[:library_book_id])

    if library_book.available?
      borrowing = current_user.borrowings.new(library_book: library_book)

      if borrowing.save
        redirect_to library_books_path, notice: "Book borrowed successfully!"
      else
        redirect_to library_book_path(library_book), alert: borrowing.errors.full_messages.to_sentence
      end
    else
      redirect_to library_book_path(library_book), alert: "This book is currently unavailable."
    end
  end

  def destroy
    Rails.logger.info "Destroying Borrowing. Params: #{params.inspect}"
    Rails.logger.info "Borrowing : #{@borrowing.inspect}"


    if @borrowing&.update(returned: true)
      redirect_to library_books_path, notice: "Book returned successfully!"
    else
      redirect_to library_books_path, alert: "Something went wrong."
    end
  end

  private
  def set_borrowing
    @borrowing = current_user.borrowings.find(params[:id])
  end
  # def borrowing_params
  #   params.require(:borrowing).permit(:id)
  # end
end
