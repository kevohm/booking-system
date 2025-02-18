
class Borrowing < ApplicationRecord
  belongs_to :user
  belongs_to :library_book

  validates :due_date, presence: true
  validate :library_book_availability, on: :create

  before_validation :set_due_date, on: :create

  private

  def set_due_date
    self.due_date ||= 2.weeks.from_now
  end

  def library_book_availability
    errors.add(:library_book, "is already borrowed") unless library_book.available?
  end
end
