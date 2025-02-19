class EnforceSingleActiveBorrowingPerBook < ActiveRecord::Migration[8.0]
  def change
      remove_index :borrowings, :library_book_id if index_exists?(:borrowings, :library_book_id)
    add_index :borrowings, :library_book_id, unique: true, where: "returned IS FALSE"
  end
end
