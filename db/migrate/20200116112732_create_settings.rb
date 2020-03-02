class CreateSettings < ActiveRecord::Migration[6.0]
  def change
    create_table :settings do |t|
        t.integer :user_id,                null: false
        t.boolean :publish_impression,     null: false, default: true

      t.timestamps
    end
    add_index :settings, :user_id,      unique: true
  end
end
