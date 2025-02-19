class LibraryBooksController < ApplicationController
  before_action :set_library_book, only: %i[show edit update destroy]

  def index
    @library_books = LibraryBook.all
    logger.debug("Current User: #{current_user.role}")
    @library_books = @library_books.where("title LIKE ?", "%#{params[:title]}%") if params[:title].present?
    @library_books = @library_books.where("author LIKE ?", "%#{params[:author]}%") if params[:author].present?
  end

  def show
  end

  def new
    @library_book = LibraryBook.new
  end

  def create
    unless current_user&.admin?
      redirect_to library_books_path, alert: "You are not authorized to add books."
      return
    end

    @library_book = LibraryBook.new(library_book_params)
    # Rails.logger.debug("Current User: #{Current.session.user}")
    if @library_book.save
      redirect_to @library_book, notice: "Book was successfully created."
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @library_book.update(library_book_params)
      redirect_to @library_book, notice: "Book was successfully updated."
    else
      render :edit
    end
  end

  def destroy
    @library_book.destroy
    redirect_to library_books_path, notice: "Book was successfully destroyed."
  end



  private

  def set_library_book
    @library_book = LibraryBook.find(params[:id])
  end

  def library_book_params
    params.require(:library_book).permit(:title, :author, :isbn)
  end
end
