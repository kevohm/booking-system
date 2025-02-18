class CreateLibraryBooks < ActiveRecord::Migration[8.0]
  def change
    create_table :library_books do |t|
      t.string :title
      t.string :author
      t.string :isbn

      t.timestamps
    end
    add_index :library_books, :isbn, unique: true
  end
end
