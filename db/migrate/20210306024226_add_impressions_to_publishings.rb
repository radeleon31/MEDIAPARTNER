class AddImpressionsToPublishings < ActiveRecord::Migration[6.0]
  def change
    add_column :publishings, :impressions, :integer
  end
end
