class AddLikesAndViewsToPublishings < ActiveRecord::Migration[6.0]
  def change
    add_column :publishings, :likes, :integer
    add_column :publishings, :views, :integer
  end
end
