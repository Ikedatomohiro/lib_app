class AddRowOrderToBooks < ActiveRecord::Migration[6.0]
  def change
    add_column :books, :row_order, :integer
  end
end
