class AddSharesToPublishings < ActiveRecord::Migration[6.0]
  def change
    add_column :publishings, :shares, :integer
  end
end
