class CreateImpressions < ActiveRecord::Migration[6.0]
  def change
    create_table :impressions do |t|
        t.integer :user_id,             null: false
        t.integer :book_id,             null: false
        t.string  :impression,          null: true
        t.string  :impression_img,      null: true
        t.boolean :tweeted_flg,         null: false, default: false
        t.timestamps
    end
  end
end
