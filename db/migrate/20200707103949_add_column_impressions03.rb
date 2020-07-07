class AddColumnImpressions03 < ActiveRecord::Migration[6.0]
  def change
    add_column :impressions, :tweeted_time, :datetime
  end
end
