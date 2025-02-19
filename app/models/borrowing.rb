class Borrowing < ApplicationRecord
  belongs_to :user
  belongs_to :library_book

  validates :due_date, presence: true
  validate :library_book_availability, on: :create

  before_validation :set_due_date, on: :create
  after_create :mark_book_unavailable
  after_update :mark_book_available_if_returned

  private

  def set_due_date
    self.due_date ||= 2.weeks.from_now
  end

  def library_book_availability
    errors.add(:library_book, "is already borrowed") unless library_book.available?
  end

  def mark_book_unavailable
    library_book.update(available: false)
  end

  def mark_book_available_if_returned
    library_book.update(available: true) if returned?
  end
end
