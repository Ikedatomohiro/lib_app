class AddColumnImpressions02 < ActiveRecord::Migration[6.0]
  def change
    add_column :impressions, :tweet_content, :string
  end
end
