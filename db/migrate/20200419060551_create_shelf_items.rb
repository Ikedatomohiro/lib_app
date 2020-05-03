class CreateShelfItems < ActiveRecord::Migration[6.0]
  def change
    create_table :shelf_items do |t|
        t.integer :shelf_id,         null: false
        t.integer :user_id,          null: false
        t.integer :book_id,          null: false
        t.integer :row_order
      t.timestamps
    end
    add_index :shelf_items, :user_id
    add_index :shelf_items, :book_id
  end
end
