class AddScheduledAtToPublishings < ActiveRecord::Migration[6.0]
  def change
    add_column :publishings, :scheduled_at, :datetime
  end
end
