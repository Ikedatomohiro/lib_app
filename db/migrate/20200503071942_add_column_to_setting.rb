class AddColumnToSetting < ActiveRecord::Migration[6.0]
  def change
    add_column :settings, :latest_shelf, :integer, null:true
  end
end
