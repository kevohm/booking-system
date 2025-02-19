class PagesController < ApplicationController
  # allow_unauthenticated_access only: :home
  def home
    # redirect_to library_books_path if authenticated?
  end
  # def dashboard
  #   redirect_to new_session_path unless authenticated?
  # end
  def profile
    redirect_to new_session_path unless authenticated?

    if current_user
      @borrowings = current_user.borrowings.where(returned: false).includes(:library_book)
    else
      @borrowings = []
    end
  end
end
