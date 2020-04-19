class CreateShelves < ActiveRecord::Migration[6.0]
  def change
    create_table :shelves do |t|
        t.integer :user_id,                 null: false
        t.string  :shelf_name,              null: false
        t.string  :shelf_tab_color,         null: true
        t.integer :row_order
      t.timestamps
    end
    add_index :shelves, :user_id
  end
end
