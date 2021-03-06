class AddAvgWatchSecToPublishings < ActiveRecord::Migration[6.0]
  def change
    add_column :publishings, :avg_watch_sec, :integer
  end
end
