class AddDefaultReturnedToBorrowings < ActiveRecord::Migration[8.0]
  def change
    change_column_default :borrowings, :returned, false
  end
end
