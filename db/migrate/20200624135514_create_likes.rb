class CreateLikes < ActiveRecord::Migration[6.0]
  def change
    create_table :likes do |t|
      t.integer :user_id,       null: false
      t.integer :impression_id, null: false

      t.timestamps
    end
    add_index :likes, :impression_id
  end
end
