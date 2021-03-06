class AddDislikesToPublishings < ActiveRecord::Migration[6.0]
  def change
    add_column :publishings, :dislikes, :integer
  end
end
