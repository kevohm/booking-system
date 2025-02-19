class LibraryBook < ApplicationRecord
  has_many :borrowings
  has_many :users, through: :borrowings

  validates :title, :author, :isbn, presence: true
  validates :isbn, uniqueness: true

  before_save :sync_availability_status

  def available?
    available
  end

  def borrowed_by?(user)
    borrowings.exists?(user: user, returned: false)
  end

  private

  def sync_availability_status
    self.available = !borrowings.exists?(returned: false)
  end
end
