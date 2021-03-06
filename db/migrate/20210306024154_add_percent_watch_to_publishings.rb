class AddPercentWatchToPublishings < ActiveRecord::Migration[6.0]
  def change
    add_column :publishings, :percent_watch, :float
  end
end
