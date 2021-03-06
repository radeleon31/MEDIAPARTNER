class AddCommentsToPublishings < ActiveRecord::Migration[6.0]
  def change
    add_column :publishings, :comments, :integer
  end
end
