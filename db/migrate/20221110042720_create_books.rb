class CreateBooks < ActiveRecord::Migration[6.1]
  def change
    create_table :books do |t|
      t.string :title
      t.string :author
      t.string :description
      t.integer :total_pages
      t.integer :year_published
      t.string :cover
      t.string :publisher
      t.string :ISBN
      t.timestamps
    end
  end
end
