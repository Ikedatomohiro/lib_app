class AddColumnToBooks < ActiveRecord::Migration[6.0]
  def change
    add_column :books, :users_thumbnail, :string
  end
end
