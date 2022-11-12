class CreateBookChats < ActiveRecord::Migration[6.1]
  def change
    create_table :book_chats do |t|
      t.references :user, null: false, foreign_key: true
      t.references :friend, references: :users, foreign_key: {to_table: :users}
      t.string :message
      t.timestamps
    end
  end
end
