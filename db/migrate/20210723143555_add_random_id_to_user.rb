class AddRandomIdToUser < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :random_id, :string
  end
end
