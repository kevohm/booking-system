class User < ApplicationRecord
  has_secure_password
  has_many :borrowings, dependent: :destroy
  # enum role: { user: 0, admin: 1 }

  has_many :sessions, dependent: :destroy

  validates :email_address, presence: true, uniqueness: true
  validates :password, presence: true, length: { minimum: 6 }, if: -> { new_record? || !password.nil? }

  normalizes :email_address, with: ->(e) { e.strip.downcase }
end
