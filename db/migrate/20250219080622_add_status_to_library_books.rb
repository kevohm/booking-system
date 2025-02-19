class AddStatusToLibraryBooks < ActiveRecord::Migration[8.0]
  def change
    add_column :library_books, :available, :boolean, default: true, null: false
  end
end
