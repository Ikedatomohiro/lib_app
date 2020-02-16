class CreateContacts < ActiveRecord::Migration[6.0]
  def change
    create_table :contacts do |t|
      t.integer    :user_id,        null: false
      t.integer    :contact_type,   null: false
      t.string     :contact_title,  null: false 
      t.string     :inquiry,        null: false
      t.string     :response,       null: true
      t.timestamps
    end
  end
end
