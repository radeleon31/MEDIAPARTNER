class AddRevenueToPublishings < ActiveRecord::Migration[6.0]
  def change
    add_column :publishings, :revenue, :integer
  end
end
