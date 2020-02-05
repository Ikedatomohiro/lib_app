class CreateBooks < ActiveRecord::Migration[6.0]
  def change
    create_table :books do |t|
        t.integer :user_id,             null: false
        t.string  :impression_link,     null: false
        t.string  :isbn,                null: false
        t.string  :title,               null: false
        t.string  :thumbnail,           null: false, default: '/assets/images/book_img.svg'
        t.date    :reading_start_date,  null: true
        t.date    :reading_end_date,    null: true
        t.integer :evaluation,          null: true
        t.timestamps
    end
  end
end