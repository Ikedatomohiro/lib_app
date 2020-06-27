class AddColumnImpressions < ActiveRecord::Migration[6.0]
  def change
    add_column :impressions, :like_count, :integer, default: 0
  end
end
