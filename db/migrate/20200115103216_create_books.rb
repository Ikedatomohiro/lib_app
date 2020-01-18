class CreateBooks < ActiveRecord::Migration[6.0]
  def change
    create_table :books do |t|
        t.integer :user_id,                null: false
        t.integer :isbn,                   null: false
        t.timestamps
    end
  end
end